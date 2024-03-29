import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_provider.dart';
import 'package:flutter_ps5_library/feature/game_details/view/game_details_screen.dart';
import 'package:flutter_ps5_library/feature/games/state/games_provider.dart';
import 'package:flutter_ps5_library/feature/games/state/games_state.dart';
import 'package:flutter_ps5_library/feature/games/view/widget/games_item_more_widget.dart';
import 'package:flutter_ps5_library/feature/games/view/widget/games_item_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class GamesScreen extends StatefulWidget {
  static String routePath = 'games';
  static String routeName = 'games';

  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  final double crossAxisSpacing = 16;
  final double paddingSize = 20;
  bool _shouldShowScrollToTop = false;

  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    _sc.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = Provider.of<GamesProvider>(context, listen: false);
      if (p.state.isFirstFetch) {
        p.fetchGames(page: 1);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Latest PS5 Games')),
      body: body,
      floatingActionButton: _shouldShowScrollToTop
          ? FloatingActionButton(
              onPressed: () => _sc.animateTo(0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut),
              child: const Icon(Icons.arrow_upward),
            )
          : null,
    );
  }

  Widget get body {
    return Consumer<GamesProvider>(
      builder: (context, p, loading) {
        if (p.state.games.isEmpty) {
          if (p.state.isFirstFetch || p.state.isFetching) {
            return loading ?? Container();
          }
          if (p.state.errMsg.isNotEmpty) return errBtn(p.state.errMsg);
          if (p.state.games.isEmpty) return errBtn('No games found');
        }
        return grid(p.state);
      },
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget errBtn(String text) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              final p = Provider.of<GamesProvider>(context, listen: false);
              p.fetchGames(page: 1);
            },
            child: const Text('Retry'),
          )
        ],
      ),
    );
  }

  Widget grid(GamesState state) {
    return RefreshIndicator(
      onRefresh: () async {
        final p = Provider.of<GamesProvider>(context, listen: false);
        p.fetchGames(page: 1);
      },
      child: GridView.builder(
        controller: _sc,
        padding: EdgeInsets.all(paddingSize),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: 16,
        ),
        itemCount: state.games.length + (state.hasMorePage ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == state.games.length) return const GamesItemMoreWidget();
          final game = state.games[index];
          return GamesItemWidget(
            game: game,
            onTap: () async {
              final p =
                  Provider.of<GameDetailsProvider>(context, listen: false);
              p.state.game = game;
              await context.pushNamed(
                GameDetailsScreen.routeName,
                pathParameters: {'id': game.id.toString()},
                queryParameters: {'title': game.name},
              );
              p.state.reset();
            },
          );
        },
      ),
    );
  }

  void _onScroll() {
    if (!mounted) return;
    setState(() => _shouldShowScrollToTop =
        _sc.position.pixels > MediaQuery.of(context).size.height);
    final itemW = ((MediaQuery.of(context).size.width -
                crossAxisSpacing +
                2 * paddingSize) /
            2)
        .ceil();
    if (_sc.position.pixels >= _sc.position.maxScrollExtent - itemW) {
      final p = Provider.of<GamesProvider>(context, listen: false);
      p.fetchGames();
    }
  }
}
