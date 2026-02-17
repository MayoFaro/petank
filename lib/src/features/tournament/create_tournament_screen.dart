import 'package:flutter/material.dart';

import '../../core/models.dart';
import '../../core/team_size_solver.dart';
import '../../state/app_controller.dart';
import '../../state/app_scope.dart';

class CreateTournamentScreen extends StatefulWidget {
  const CreateTournamentScreen({super.key});

  @override
  State<CreateTournamentScreen> createState() => _CreateTournamentScreenState();
}

class _CreateTournamentScreenState extends State<CreateTournamentScreen> {
  final _nameController = TextEditingController();
  final Set<int> _selectedPlayerIds = {};
  final List<_DraftPlayer> _draftPlayers = [];
  final TeamSizeSolver _teamSizeSolver = const TeamSizeSolver();

  int _roundsCount = 4;
  TeamSizePreference _preference = TeamSizePreference.prefer2;
  bool _selectionInitialized = false;

  @override
  void dispose() {
    _nameController.dispose();
    for (final draft in _draftPlayers) {
      draft.controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final players = controller.players;
    _ensureInitialSelection(players);

    final selectedCount =
        _selectedPlayerIds.length +
        _draftPlayers.where((d) => d.controller.text.trim().isNotEmpty).length;
    final templateLabel = _computeTemplateLabel(selectedCount);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nom du tournoi',
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: _roundsCount,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Nombre de tours',
                  ),
                  items: const [
                    DropdownMenuItem(value: 4, child: Text('4 tours')),
                    DropdownMenuItem(value: 5, child: Text('5 tours')),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _roundsCount = value);
                    }
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<TeamSizePreference>(
                  value: _preference,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Préférence équipes',
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: TeamSizePreference.prefer2,
                      child: Text('Plutôt 2'),
                    ),
                    DropdownMenuItem(
                      value: TeamSizePreference.prefer3,
                      child: Text('Plutôt 3'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _preference = value);
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Template appliqué: $templateLabel',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 12),
          const Text('Joueurs du pool'),
          const SizedBox(height: 6),
          Expanded(
            child: ListView(
              children: [
                ...players.map(
                  (p) => Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    decoration: BoxDecoration(
                      color: _roleColor(p.role),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: CheckboxListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(p.name),
                      subtitle: Text(_roleLabel(p.role)),
                      value: _selectedPlayerIds.contains(p.id),
                      onChanged: (selected) {
                        setState(() {
                          if (selected == true) {
                            _selectedPlayerIds.add(p.id);
                          } else {
                            _selectedPlayerIds.remove(p.id);
                          }
                        });
                      },
                    ),
                  ),
                ),
                const Divider(height: 24),
                const Text('Nouveaux joueurs à ajouter au pool'),
                const SizedBox(height: 8),
                ..._draftPlayers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final draft = entry.value;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: draft.controller,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Nouveau joueur ${index + 1}',
                            ),
                            onChanged: (_) => setState(() {}),
                          ),
                        ),
                        const SizedBox(width: 8),
                        DropdownButton<PlayerRole>(
                          value: draft.role,
                          items: PlayerRole.values
                              .map(
                                (r) => DropdownMenuItem(
                                  value: r,
                                  child: Text(_shortRoleLabel(r)),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value != null) {
                              setState(() => draft.role = value);
                            }
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              draft.controller.dispose();
                              _draftPlayers.removeAt(index);
                            });
                          },
                          icon: const Icon(Icons.delete_outline),
                        ),
                      ],
                    ),
                  );
                }),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      setState(() {
                        _draftPlayers.add(
                          _DraftPlayer(controller: TextEditingController()),
                        );
                      });
                    },
                    icon: const Icon(Icons.person_add_alt_1),
                    label: const Text('Ajouter un champ joueur'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Sélectionnés: $selectedCount joueur${selectedCount > 1 ? 's' : ''}',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: controller.isBusy
                  ? null
                  : () => _createTournament(context),
              icon: const Icon(Icons.sports_handball),
              label: Text(
                controller.isBusy ? 'Génération...' : 'Créer le tournoi',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _ensureInitialSelection(List<Player> players) {
    if (_selectionInitialized || players.isEmpty) {
      return;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _selectionInitialized) {
        return;
      }
      setState(() {
        _selectedPlayerIds
          ..clear()
          ..addAll(players.map((p) => p.id));
        _selectionInitialized = true;
      });
    });
  }

  String _computeTemplateLabel(int playerCount) {
    if (playerCount < 4) {
      return '-';
    }

    try {
      final template = _teamSizeSolver.solve(
        playerCount: playerCount,
        preference: _preference,
      );
      return '${template.teamsOf2}x2, ${template.teamsOf3}x3';
    } catch (_) {
      return 'incompatible pour $playerCount joueurs';
    }
  }

  Future<void> _createTournament(BuildContext context) async {
    final controller = AppScope.of(context);
    try {
      await controller.createTournament(
        name: _nameController.text,
        roundsCount: _roundsCount,
        preference: _preference,
        selectedPlayerIds: _selectedPlayerIds.toList(),
        newPlayers: _draftPlayers
            .map((d) => NewPlayerInput(name: d.controller.text, role: d.role))
            .toList(),
      );

      if (!context.mounted) return;
      final msg = controller.consumeFlashMessage();
      if (msg.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(msg)));
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  String _roleLabel(PlayerRole role) {
    return switch (role) {
      PlayerRole.beginner => 'Débutant',
      PlayerRole.pointer => 'Pointeur',
      PlayerRole.shooter => 'Tireur',
    };
  }

  String _shortRoleLabel(PlayerRole role) {
    return switch (role) {
      PlayerRole.beginner => 'Débutant',
      PlayerRole.pointer => 'Pointeur',
      PlayerRole.shooter => 'Tireur',
    };
  }

  Color _roleColor(PlayerRole role) {
    return switch (role) {
      PlayerRole.beginner => const Color(0xFFFFF3CD),
      PlayerRole.pointer => const Color(0xFFD9F2E6),
      PlayerRole.shooter => const Color(0xFFFFE0E0),
    };
  }
}

class _DraftPlayer {
  _DraftPlayer({required this.controller, this.role = PlayerRole.beginner});

  final TextEditingController controller;
  PlayerRole role;
}
