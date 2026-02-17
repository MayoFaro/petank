import 'package:flutter/material.dart';

class LiveRoundScreen extends StatelessWidget {
  const LiveRoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Saisie score A/B + operations live add/remove/replace.'),
          SizedBox(height: 12),
          Text('Les modifications n\'impactent que le tour courant (V1).'),
        ],
      ),
    );
  }
}
