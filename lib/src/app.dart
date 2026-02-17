import 'package:flutter/material.dart';

import 'features/player_pool/pool_screen.dart';
import 'features/ranking/final_ranking_screen.dart';
import 'features/round/live_round_screen.dart';
import 'features/tournament/create_tournament_screen.dart';
import 'features/tournament/plan_overview_screen.dart';
import 'state/app_controller.dart';
import 'state/app_scope.dart';

class PetankApp extends StatefulWidget {
  const PetankApp({super.key, this.controller});

  final AppController? controller;

  @override
  State<PetankApp> createState() => _PetankAppState();
}

class _PetankAppState extends State<PetankApp> {
  late final AppController _controller;
  int _index = 0;

  static const _screens = [
    PlayerPoolScreen(),
    CreateTournamentScreen(),
    PlanOverviewScreen(),
    LiveRoundScreen(),
    FinalRankingScreen(),
  ];

  static const _titles = [
    'Pool joueurs',
    'Créer tournoi',
    'Aperçu plan',
    'Tour en cours',
    'Classement final',
  ];

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? AppController.live();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      controller: _controller,
      child: MaterialApp(
        title: 'Petank',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0D7A5F)),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(title: Text(_titles[_index])),
          body: IndexedStack(index: _index, children: _screens),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _index,
            onDestinationSelected: (value) => setState(() => _index = value),
            destinations: const [
              NavigationDestination(icon: Icon(Icons.people), label: 'Pool'),
              NavigationDestination(
                icon: Icon(Icons.add_circle_outline),
                label: 'Tournoi',
              ),
              NavigationDestination(icon: Icon(Icons.view_list), label: 'Plan'),
              NavigationDestination(
                icon: Icon(Icons.sports_score),
                label: 'Tour',
              ),
              NavigationDestination(
                icon: Icon(Icons.emoji_events),
                label: 'Classement',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
