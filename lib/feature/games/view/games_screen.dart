import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/games/state/games_provider.dart';
import 'package:flutter_ps5_library/feature/games/state/games_state.dart';
import 'package:provider/provider.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest PS5 Games'),
        actions: [
          IconButton(
            onPressed: () {
              final p = Provider.of<GamesProvider>(context, listen: false);
              p.fetchGames();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: body,
    );
  }

  Widget get body {
    return Consumer<GamesProvider>(
      builder: (context, p, loading) {
        if (p.state.games.isEmpty) {
          if (p.state.isFetching) return loading ?? Container();
          if (p.state.errMsg.isNotEmpty) {
            return Center(child: Text(p.state.errMsg));
          }
          if (p.state.games.isEmpty) {
            return const Center(child: Text('No games found'));
          }
        }
        return grid(p.state);
      },
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget grid(GamesState state) {
    return GridView.builder(
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: state.games.length,
      itemBuilder: (context, index) {
        final game = state.games[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              if (game.backgroundImage?.isNotEmpty ?? false)
                Image.network(game.backgroundImage ?? '',
                    height: 125, fit: BoxFit.cover)
              else
                SizedBox(height: 125, child: Icon(Icons.gamepad)),
              Text(game.name),
            ],
          ),
        );
      },
    );
  }
}
