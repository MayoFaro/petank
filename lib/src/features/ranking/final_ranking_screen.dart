import 'package:flutter/material.dart';

class FinalRankingScreen extends StatelessWidget {
  const FinalRankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Classement: victoires desc, puis diff points desc.'),
          SizedBox(height: 12),
          Text('Egalite parfaite: ex aequo.'),
        ],
      ),
    );
  }
}
