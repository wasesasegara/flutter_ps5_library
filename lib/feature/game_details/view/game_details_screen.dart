import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_provider.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_state.dart';
import 'package:flutter_ps5_library/feature/games/view/widget/games_item_widget.dart';
import 'package:flutter_ps5_library/utils/widget/text_placeholder_widget.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool _isOpeningWebsite = false;
  int _screenshotPageIndex = 0;

  final ScrollController _sc = ScrollController();
  PageController? _pc;

  @override
  void initState() {
    super.initState();
    _sc.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.id == null) {
        _showNoIdAlertDialog();
        return;
      }
      final p = Provider.of<GameDetailsProvider>(context, listen: false);
      await p.fetchGame(widget.id!);
      String image = p.state.game?.bgImageUrl ?? '';
      if (image.isEmpty && mounted) {
        setState(() => _shouldShowNavigationBar = true);
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    _pc?.dispose();
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
            details(p.state),
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

  Widget details(GameDetailsState state) {
    final g = state.game!;
    String image = g.bgImageUrl;
    late final Widget desc;
    if (g.description?.isEmpty ?? true) {
      if (state.isFetching) {
        desc = const TextPlaceholderWidget(numLines: 5);
      } else {
        desc = const Text('No description');
      }
    } else {
      desc = HtmlWidget(g.description ?? 'No description');
    }
    return ListView(controller: _sc, children: [
      if (image.isNotEmpty)
        CachedNetworkImage(
          progressIndicatorBuilder: (context, url, progress) => Center(
            child: CircularProgressIndicator(value: progress.progress),
          ),
          errorWidget: (context, url, error) => const SizedBox(),
          imageUrl: image,
          memCacheWidth: MediaQuery.of(context).size.width.toInt(),
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      if (g.name?.isNotEmpty ?? false)
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Text(
            g.name ?? 'No name',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      if (g.rating > 0 || (g.released?.isNotEmpty ?? false))
        Padding(
          padding: const EdgeInsets.all(20).copyWith(top: 8, bottom: 0),
          child: Row(
            children: [
              if (g.rating > 0) ...[
                const Text('Rating'),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(4),
                  color: ratingColor(g.rating),
                  child: Text(
                    g.rating.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                const Spacer(),
              ],
              if (g.released?.isNotEmpty ?? false) ...[
                const Text('Released'),
                const SizedBox(width: 8),
                Text(g.released ?? ''),
              ],
            ],
          ),
        ),
      Padding(
        padding: const EdgeInsets.all(20).copyWith(bottom: 0),
        child: desc,
      ),
      if (g.updated != null)
        Padding(
          padding: const EdgeInsets.all(20).copyWith(top: 8, bottom: 0),
          child: Text(
            'Updated at '
            '${formatDate(g.updated!, [d, ' ', M, ' ', yyyy])}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      if (g.website?.isNotEmpty ?? false)
        GestureDetector(
          onTap: () => _openWebsite(g.website!),
          child: Padding(
            padding: const EdgeInsets.all(20)
                .copyWith(top: g.updated != null ? 0 : 8, bottom: 0),
            child: Text(
              g.website!,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ),
      if (g.shortScreenshots.isNotEmpty)
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20).copyWith(bottom: 0),
              child: Text(
                'Screenshots',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(height: 8),
            _screenshots(g)
          ],
        ),
    ]);
  }

  SizedBox _screenshots(Game g) {
    return SizedBox(
      height: 200,
      child: Builder(builder: (context) {
        final initialPage = g.shortScreenshots.length > 1 ? 1 : 0;
        _setupPageController(initialPage);
        return Stack(
          children: [
            PageView(
              controller: _pc,
              children: [
                for (final img in g.shortScreenshots.map((e) => e.image))
                  CachedNetworkImage(
                    progressIndicatorBuilder: (context, url, progress) =>
                        Center(
                      child:
                          CircularProgressIndicator(value: progress.progress),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    imageUrl: img,
                    memCacheWidth: MediaQuery.of(context).size.width.toInt(),
                    height: 200,
                    fit: BoxFit.cover,
                  )
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: DotsIndicator(
                position: _screenshotPageIndex,
                dotsCount: g.shortScreenshots.length,
              ),
            )
          ],
        );
      }),
    );
  }

  void _setupPageController(int initPage) {
    if (_pc != null) return;
    _pc = PageController(initialPage: initPage);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pc?.addListener(() {
        if (!mounted) return;
        setState(() => _screenshotPageIndex = _pc!.page!.round());
      });
      if (!mounted) return;
      setState(() => _screenshotPageIndex = initPage);
    });
  }

  Future<void> _showNoIdAlertDialog() {
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

  Future<void> _openWebsite(String url) async {
    if (_isOpeningWebsite) return;
    _isOpeningWebsite = true;
    final uri = Uri.parse(url);
    try {
      await launchUrl(uri);
      _isOpeningWebsite = false;
    } catch (e) {
      _isOpeningWebsite = false;
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  void _onScroll() {
    if (!mounted) return;
    final p = Provider.of<GameDetailsProvider>(context, listen: false);
    final estTitlePos =
        (p.state.game?.bgImageUrl.isNotEmpty ?? false) ? 300 : 0;
    setState(
        () => _shouldShowNavigationBar = _sc.position.pixels >= estTitlePos);
  }
}
