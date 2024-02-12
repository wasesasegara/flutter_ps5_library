import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_provider.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
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
  bool _shouldShowNavigationBar = false;

  final ScrollController _sc = ScrollController();

  @override
  void initState() {
    super.initState();
    _sc.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.id == null) {
        showNoIdAlertDialog();
        return;
      }
      final p = Provider.of<GameDetailsProvider>(context, listen: false);
      p.fetchGame(widget.id!);
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
      appBar: _shouldShowNavigationBar
          ? AppBar(title: Text(widget.title ?? 'Game Detail'))
          : null,
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
        return Stack(
          children: [
            details(p.state.game!),
            if (!_shouldShowNavigationBar)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: transparentAppBar,
              ),
          ],
        );
      },
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  AppBar get transparentAppBar {
    return AppBar(
      leading: IconButton(
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black
                .withOpacity(0.6), // Replace with your desired color
          ),
          padding: const EdgeInsets.all(8),
          child: const Icon(Icons.arrow_back),
        ),
        onPressed: context.pop,
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget details(Game g) {
    String image = g.bgImageUrl;
    return ListView(controller: _sc, children: [
      CachedNetworkImage(
        progressIndicatorBuilder: (context, url, progress) => Center(
          child: CircularProgressIndicator(value: progress.progress),
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
        imageUrl: image,
        memCacheWidth: MediaQuery.of(context).size.width.toInt(),
        width: double.infinity,
        fit: BoxFit.cover,
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Text(g.name ?? 'No name'),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: HtmlWidget(g.description ?? 'No description'),
      ),
    ]);
  }

  Future<dynamic> showNoIdAlertDialog() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('No game ID provided'),
          content: const Text('Make sure you provided a game ID'),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.pop();
                if (context.canPop()) context.pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _onScroll() {
    if (!mounted) return;
    final p = Provider.of<GameDetailsProvider>(context, listen: false);
    final estTitlePos =
        (p.state.game?.bgImageUrl.isNotEmpty ?? false) ? 400 : 0;
    setState(
        () => _shouldShowNavigationBar = _sc.position.pixels >= estTitlePos);
  }
}
