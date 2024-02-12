import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/games/state/games_provider.dart';
import 'package:provider/provider.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final p = Provider.of<GamesProvider>(context, listen: false);
            final result = await p.fetchGames();
            debugPrint(result.toString());
          },
          child: const Text('Games'),
        ),
      ),
    );
  }
}
