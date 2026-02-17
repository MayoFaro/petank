# TODO - Petank (prochaines étapes)

## P0 - Fonctionnel tournoi
- Implémenter l'écran **Tour en cours** connecté DB:
  - affichage du tour actif (équipes + matchs)
  - saisie complète `scoreA/scoreB` par match
  - persistance des scores dans `MatchPlan`
  - passage d'état de round `PLANNED -> ACTIVE -> DONE`
- Implémenter les opérations live du tour courant avec persistance:
  - ajouter joueur dans équipe de 2 (devient 3)
  - retirer joueur d'équipe de 3 (devient 2)
  - remplacer un joueur par un autre
  - impact limité au tour courant (V1)
- Implémenter l'écran **Classement final** branché aux scores persistés:
  - tri Victoires desc
  - puis Différence de points desc
  - égalité parfaite => ex aequo

## P1 - Données et navigation
- Charger le **dernier tournoi actif** au démarrage (au lieu de rester uniquement en mémoire UI)
- Ajouter un écran/liste de tournois pour reprendre un tournoi existant
- Ajouter DAO dédiés `round/team/match` pour lecture/écriture fine (aujourd'hui write-centric sur création)

## P1 - Qualité algo
- Ajouter des tests de non-régression sur cas limites:
  - forte proportion de débutants
  - tailles impaires proches (15, 17, 19, 21, 23, 25)
  - stabilité du template selon préférence 2/3
- Ajouter un mode diagnostic utilisateur quand génération impossible (message guidé)

## P2 - UX
- Ajouter feedback visuel de sauvegarde score (toast + état du match)
- Ajouter filtres/tri sur le pool joueurs
- Ajouter historique simple des paires `playedWith` / `faced`

## P2 - Technique
- Ajouter contraintes DB complémentaires (unicité nom joueur activePool, index utiles)
- Ajouter stratégie de migration Drift (`schemaVersion > 1`)
- Ajouter tests d'intégration Drift (création tournoi -> lecture plan -> classement)
