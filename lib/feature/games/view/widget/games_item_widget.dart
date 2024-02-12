import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';

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
    String image = game.bgImageUrl;
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
                memCacheWidth: MediaQuery.of(context).size.width.toInt(),
                height: height,
                fit: BoxFit.cover,
              )
            else
              Container(
                color: Theme.of(context).primaryColor.withOpacity(0.5),
                width: double.infinity,
                height: height,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.gamepad),
                    SizedBox(height: 4),
                    Text(
                      'No preview available',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            Positioned(
              bottom: 0,
              child: Container(
                width: cons.maxWidth,
                padding: const EdgeInsets.all(8),
                color: Colors.black.withOpacity(0.6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (game.name?.isNotEmpty ?? false)
                      Text(
                        game.name!,
                      ),
                    if (game.released?.isNotEmpty ?? false)
                      Text(
                        'Release date: ${game.released!}',
                        style: const TextStyle(fontSize: 11),
                      ),
                    if ((game.name?.isNotEmpty ?? false) &&
                        (game.description?.isNotEmpty ?? false))
                      const SizedBox(height: 4),
                    if (game.description?.isNotEmpty ?? false)
                      Text(
                        game.description!,
                      ),
                  ],
                ),
              ),
            ),
            if (game.rating > 0)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  color: ratingColor(game.rating),
                  child: Text(
                    game.rating.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

Color ratingColor(double rating) {
  if (rating > 3) return const Color.fromARGB(255, 74, 157, 77);
  if (rating > 2) return const Color.fromARGB(255, 195, 117, 0);
  return const Color.fromARGB(255, 181, 41, 31);
}
