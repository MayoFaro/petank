# Architecture V1

- `lib/src/core/`
  - `models.dart`: modeles tournoi (joueurs, equipes, matchs, rounds, classement)
  - `team_size_solver.dart`: resolution du template 2/3 (2a+3b=N, T pair, preference)
  - `tournament_engine.dart`: generation complete des tours, appariement des matchs, classement
  - `round_live_ops.dart`: operations live du tour courant (add/remove/replace)
- `lib/src/data/local/`
  - `app_database.dart`: schema Drift SQLite local
- `lib/src/features/`
  - `player_pool/`: ecran pool joueurs
  - `tournament/`: creation tournoi + apercu plan
  - `round/`: gestion tour courant
  - `ranking/`: classement final
- `lib/src/app.dart`
  - shell UI (navigation 5 onglets)

## Generation (moteur)

1. Calcul template de tailles via `TeamSizeSolver`.
2. Pour chaque tour:
   - generation d'equipes par backtracking borne + fonction de cout (hard/soft)
   - penalisation des binomes deja joues (`playedWith`)
   - evitement equipes identiques tour precedent (hard puis fallback soft)
   - appariement des matchs greedy avec minimisation de `faced`
3. Classement: victoires desc, diff points desc.
