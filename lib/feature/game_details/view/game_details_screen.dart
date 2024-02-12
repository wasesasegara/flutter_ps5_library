import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_provider.dart';
import 'package:provider/provider.dart';

class GameDetailsScreen extends StatefulWidget {
  static String routeName = 'game-detail';

  final String? id;
  final String? title;

  const GameDetailsScreen({super.key, required this.id, this.title});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  void initState() {
    super.initState();
    final p = Provider.of<GameDetailsProvider>(context, listen: false);
    p.state.reset();
    if (widget.id == null) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      p.fetchGame(widget.id!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? 'Game Detail')),
      body: body,
    );
  }

  Widget get body {
    if (widget.id == null) {
      return const Center(child: Text('Game ID not provided'));
    }
    return Consumer<GameDetailsProvider>(
      builder: (context, p, loading) {
        if (p.state.game == null) {
          if (p.state.isFirstFetch || p.state.isFetching) {
            return loading ?? Container();
          }
          if (p.state.errMsg.isNotEmpty) {
            return Center(child: Text(p.state.errMsg));
          }
          return const Center(child: Text('Details not found'));
        }
        return details(p.state.game!);
      },
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget details(Game g) {
    return Center(child: Text(g.id.toString()));
  }
}