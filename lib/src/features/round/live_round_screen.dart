import 'package:flutter/material.dart';

import '../../core/models.dart';
import '../../state/app_controller.dart';
import '../../state/app_scope.dart';

class LiveRoundScreen extends StatelessWidget {
  const LiveRoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final plan = controller.currentPlan;
    final round = controller.activeRound;

    if (plan == null || round == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Aucun tournoi actif. Crée un tournoi d’abord.'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Tour actif: '),
              DropdownButton<int>(
                value: controller.activeRoundIndex,
                items: List.generate(
                  plan.rounds.length,
                  (i) =>
                      DropdownMenuItem(value: i, child: Text('Tour ${i + 1}')),
                ),
                onChanged: (value) {
                  if (value != null) {
                    controller.setActiveRoundIndex(value);
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              children: [
                ...round.matches.map(
                  (match) => _MatchCard(
                    key: ValueKey(
                      'round-${round.roundIndex}-match-${match.matchIndex}',
                    ),
                    match: match,
                  ),
                ),
                const SizedBox(height: 8),
                const Text('Équipes du tour (opérations live)'),
                const SizedBox(height: 6),
                ...round.teams.map((team) => _TeamCard(team: team)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MatchCard extends StatefulWidget {
  const _MatchCard({super.key, required this.match});

  final MatchAssignment match;

  @override
  State<_MatchCard> createState() => _MatchCardState();
}

class _MatchCardState extends State<_MatchCard> {
  late final TextEditingController _aController;
  late final TextEditingController _bController;

  @override
  void initState() {
    super.initState();
    _aController = TextEditingController(
      text: widget.match.scoreA?.toString() ?? '',
    );
    _bController = TextEditingController(
      text: widget.match.scoreB?.toString() ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant _MatchCard oldWidget) {
    super.didUpdateWidget(oldWidget);

    final matchChanged =
        oldWidget.match.roundIndex != widget.match.roundIndex ||
        oldWidget.match.matchIndex != widget.match.matchIndex;
    final scoreChanged =
        oldWidget.match.scoreA != widget.match.scoreA ||
        oldWidget.match.scoreB != widget.match.scoreB;

    if (matchChanged || scoreChanged) {
      _aController.text = widget.match.scoreA?.toString() ?? '';
      _bController.text = widget.match.scoreB?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _aController.dispose();
    _bController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teamA = widget.match.teamA.players.map((p) => p.name).join(' / ');
    final teamB = widget.match.teamB.players.map((p) => p.name).join(' / ');
    final isSaved = widget.match.scoreA != null && widget.match.scoreB != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Match ${widget.match.matchIndex + 1}'),
            const SizedBox(height: 6),
            Text('A: $teamA'),
            Text('B: $teamB'),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _aController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Score A',
                      filled: isSaved,
                      fillColor: isSaved ? const Color(0xFFD9F2E6) : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _bController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Score B',
                      filled: isSaved,
                      fillColor: isSaved ? const Color(0xFFD9F2E6) : null,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton(
                  onPressed: () async {
                    final scoreA = int.tryParse(_aController.text.trim());
                    final scoreB = int.tryParse(_bController.text.trim());
                    if (scoreA == null || scoreB == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Saisis deux scores valides.'),
                        ),
                      );
                      return;
                    }

                    try {
                      await AppScope.of(context).saveMatchScore(
                        matchIndex: widget.match.matchIndex,
                        scoreA: scoreA,
                        scoreB: scoreB,
                      );

                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Score enregistré.')),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    }
                  },
                  child: Text(isSaved ? 'Modifier' : 'Sauver'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({required this.team});

  final TeamAssignment team;

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final members = team.players.map((p) => p.name).join(', ');

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Text('Équipe ${team.teamIndex + 1} (${team.size})'),
        subtitle: Text(members),
        trailing: PopupMenuButton<String>(
          onSelected: (value) async {
            switch (value) {
              case 'add':
                await _onAdd(context, controller);
              case 'remove':
                await _onRemove(context, controller);
              case 'replace':
                await _onReplace(context, controller);
            }
          },
          itemBuilder: (context) => const [
            PopupMenuItem(value: 'add', child: Text('Ajouter joueur (2 -> 3)')),
            PopupMenuItem(
              value: 'remove',
              child: Text('Retirer joueur (3 -> 2)'),
            ),
            PopupMenuItem(value: 'replace', child: Text('Remplacer joueur')),
          ],
        ),
      ),
    );
  }

  Future<void> _onAdd(BuildContext context, AppController controller) async {
    if (team.size != 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ajout possible uniquement sur une équipe de 2.'),
        ),
      );
      return;
    }

    final bench = controller.availableBenchForActiveRound;
    var createNew = bench.isEmpty;
    Player? selectedExisting = bench.isNotEmpty ? bench.first : null;
    final nameCtrl = TextEditingController();
    var role = PlayerRole.beginner;

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Ajouter un joueur'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (bench.isNotEmpty) ...[
                    SwitchListTile(
                      value: createNew,
                      onChanged: (v) => setState(() => createNew = v),
                      title: Text(
                        createNew ? 'Nouveau joueur' : 'Joueur existant',
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  if (!createNew && bench.isNotEmpty)
                    DropdownButtonFormField<Player>(
                      value: selectedExisting,
                      items: bench
                          .map(
                            (p) =>
                                DropdownMenuItem(value: p, child: Text(p.name)),
                          )
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selectedExisting = value),
                    ),
                  if (createNew) ...[
                    TextField(
                      controller: nameCtrl,
                      decoration: const InputDecoration(labelText: 'Nom'),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<PlayerRole>(
                      value: role,
                      items: PlayerRole.values
                          .map(
                            (r) => DropdownMenuItem(
                              value: r,
                              child: Text(_roleLabel(r)),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) setState(() => role = value);
                      },
                    ),
                  ],
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: const Text('Annuler'),
                ),
                FilledButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: const Text('Valider'),
                ),
              ],
            );
          },
        );
      },
    );

    if (ok != true) {
      nameCtrl.dispose();
      return;
    }

    Player? added;
    try {
      if (createNew) {
        final name = nameCtrl.text.trim();
        if (name.isEmpty) {
          throw const TournamentGenerationException(
            'Le nom joueur est requis.',
          );
        }
        added = await controller.createPoolPlayer(name: name, role: role);
      } else {
        added = selectedExisting;
      }

      if (added == null) {
        throw const TournamentGenerationException('Aucun joueur sélectionné.');
      }

      final success = controller.addPlayerToActiveTeam(
        teamIndex: team.teamIndex,
        player: added!,
      );
      if (!success) {
        throw const TournamentGenerationException('Ajout refusé.');
      }

      final impactFuture = await _askFutureImpact(context);
      if (impactFuture == true) {
        await controller.applyChangeToFutureRounds(
          type: FutureImpactChangeType.add,
          inPlayer: added,
        );
      }

      if (context.mounted) {
        final msg = controller.consumeFlashMessage();
        if (msg.isNotEmpty) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(msg)));
        }
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } finally {
      nameCtrl.dispose();
    }
  }

  Future<void> _onRemove(BuildContext context, AppController controller) async {
    if (team.size != 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Retrait possible uniquement pour une équipe de 3.'),
        ),
      );
      return;
    }

    Player? selected = team.players.first;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Retirer un joueur'),
        content: StatefulBuilder(
          builder: (context, setState) => DropdownButtonFormField<Player>(
            value: selected,
            items: team.players
                .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
                .toList(),
            onChanged: (value) => setState(() => selected = value),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Valider'),
          ),
        ],
      ),
    );

    if (ok == true && selected != null) {
      final success = controller.removePlayerFromActiveTeam(
        teamIndex: team.teamIndex,
        playerId: selected!.id,
      );
      if (!success) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Retrait refusé.')));
        }
        return;
      }

      final impactFuture = await _askFutureImpact(context);
      if (impactFuture == true) {
        try {
          await controller.applyChangeToFutureRounds(
            type: FutureImpactChangeType.remove,
            outPlayerId: selected!.id,
          );

          if (context.mounted) {
            final msg = controller.consumeFlashMessage();
            if (msg.isNotEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            }
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }
      }
    }
  }

  Future<void> _onReplace(
    BuildContext context,
    AppController controller,
  ) async {
    final bench = controller.availableBenchForActiveRound;
    if (bench.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Aucun joueur disponible pour remplacement.'),
        ),
      );
      return;
    }

    Player? outPlayer = team.players.first;
    Player? inPlayer = bench.first;

    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remplacer un joueur'),
        content: StatefulBuilder(
          builder: (context, setState) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Player>(
                value: outPlayer,
                decoration: const InputDecoration(labelText: 'Sortant'),
                items: team.players
                    .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
                    .toList(),
                onChanged: (value) => setState(() => outPlayer = value),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<Player>(
                value: inPlayer,
                decoration: const InputDecoration(labelText: 'Entrant'),
                items: bench
                    .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
                    .toList(),
                onChanged: (value) => setState(() => inPlayer = value),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Valider'),
          ),
        ],
      ),
    );

    if (ok == true && outPlayer != null && inPlayer != null) {
      final success = controller.replacePlayerInActiveTeam(
        teamIndex: team.teamIndex,
        outPlayerId: outPlayer!.id,
        inPlayer: inPlayer!,
      );
      if (!success) {
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Remplacement refusé.')));
        }
        return;
      }

      final impactFuture = await _askFutureImpact(context);
      if (impactFuture == true) {
        try {
          await controller.applyChangeToFutureRounds(
            type: FutureImpactChangeType.replace,
            outPlayerId: outPlayer!.id,
            inPlayer: inPlayer,
          );

          if (context.mounted) {
            final msg = controller.consumeFlashMessage();
            if (msg.isNotEmpty) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(msg)));
            }
          }
        } catch (e) {
          if (context.mounted) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
          }
        }
      }
    }
  }

  Future<bool?> _askFutureImpact(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Impacter les tours suivants ?'),
        content: const Text(
          'Le tour courant reste inchangé. Si tu valides, les tours suivants seront recalculés en tenant compte des tours déjà effectués.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Non'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Oui'),
          ),
        ],
      ),
    );
  }

  String _roleLabel(PlayerRole role) {
    return switch (role) {
      PlayerRole.beginner => 'Débutant',
      PlayerRole.pointer => 'Pointeur',
      PlayerRole.shooter => 'Tireur',
    };
  }
}
