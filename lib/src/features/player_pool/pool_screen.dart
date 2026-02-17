import 'package:flutter/material.dart';

import '../../core/models.dart';
import '../../state/app_scope.dart';

class PlayerPoolScreen extends StatefulWidget {
  const PlayerPoolScreen({super.key});

  @override
  State<PlayerPoolScreen> createState() => _PlayerPoolScreenState();
}

class _PlayerPoolScreenState extends State<PlayerPoolScreen> {
  final _nameController = TextEditingController();
  final _listController = ScrollController();
  PlayerRole _newRole = PlayerRole.beginner;

  @override
  void dispose() {
    _nameController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = AppScope.of(context);
    final players = controller.players;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Joueurs actifs: ${players.length}'),
          const SizedBox(height: 8),
          Expanded(
            child: players.isEmpty
                ? const Center(
                    child: Text(
                      'Aucun joueur. Ajoute ton premier joueur ci-dessous.',
                    ),
                  )
                : ListView.separated(
                    controller: _listController,
                    itemCount: players.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 6),
                    itemBuilder: (context, index) {
                      final p = players[index];
                      return Material(
                        color: _roleColor(p.role),
                        borderRadius: BorderRadius.circular(10),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          title: Text(p.name),
                          subtitle: Text(_roleLabel(p.role)),
                          trailing: Wrap(
                            spacing: 8,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit_outlined),
                                onPressed: () => _openEditDialog(context, p),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete_outline),
                                onPressed: () async {
                                  await controller.deletePlayer(p.id);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nom joueur',
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<PlayerRole>(
                  value: _newRole,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Rôle',
                  ),
                  items: PlayerRole.values
                      .map(
                        (role) => DropdownMenuItem(
                          value: role,
                          child: Text(_roleLabel(role)),
                        ),
                      )
                      .toList(),
                  onChanged: (role) {
                    if (role != null) {
                      setState(() => _newRole = role);
                    }
                  },
                ),
              ),
              const SizedBox(width: 8),
              FilledButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Ajouter'),
                onPressed: () async {
                  try {
                    await controller.addPlayer(_nameController.text, _newRole);
                    _nameController.clear();
                    if (_listController.hasClients) {
                      _listController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                      );
                    }
                  } catch (e) {
                    _showError(context, e.toString());
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _openEditDialog(BuildContext context, Player player) async {
    final controller = AppScope.of(context);
    final nameController = TextEditingController(text: player.name);
    var role = player.role;

    final saved = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier joueur'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nom'),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<PlayerRole>(
                value: role,
                decoration: const InputDecoration(labelText: 'Rôle'),
                items: PlayerRole.values
                    .map(
                      (r) => DropdownMenuItem(
                        value: r,
                        child: Text(_roleLabel(r)),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    role = value;
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );

    if (saved == true) {
      try {
        await controller.updatePlayer(
          id: player.id,
          name: nameController.text,
          role: role,
        );
      } catch (e) {
        if (context.mounted) {
          _showError(context, e.toString());
        }
      }
    }

    nameController.dispose();
  }

  String _roleLabel(PlayerRole role) {
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

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
