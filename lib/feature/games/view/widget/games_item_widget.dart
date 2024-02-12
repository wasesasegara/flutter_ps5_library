import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/games/domain/entity/game.dart';

class GamesItemWidget extends StatelessWidget {
  final VoidCallback onTap;
  final Game game;

  const GamesItemWidget({
    super.key,
    required this.onTap,
    required this.game,
  });

  @override
  Widget build(BuildContext context) {
    String image =
        game.backgroundImage ?? game.shortScreenshots.firstOrNull ?? '';
    return LayoutBuilder(builder: (context, cons) {
      final height = cons.maxWidth;
      return InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            if (image.isNotEmpty)
              CachedNetworkImage(
                progressIndicatorBuilder: (context, url, progress) => Center(
                  child: CircularProgressIndicator(value: progress.progress),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                imageUrl: image,
                memCacheHeight: 125,
                height: height,
                fit: BoxFit.cover,
              )
            else
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                width: double.infinity,
                height: height,
                child: const Icon(Icons.gamepad, color: Colors.white),
              ),
            Positioned(
              bottom: 0,
              child: Container(
                width: cons.maxWidth,
                padding: const EdgeInsets.all(8),
                color: Colors.black.withOpacity(0.6),
                child: Text(
                  game.name,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
