import 'package:flutter/foundation.dart';
import 'package:flutter_ps5_library/api/api_config.dart';
import 'package:flutter_ps5_library/feature/games/data/games_repository_impl.dart';
import 'package:flutter_ps5_library/feature/games/domain/data/games_repository.dart';
import 'package:flutter_ps5_library/feature/games/domain/entity/game.dart';
import 'package:flutter_ps5_library/feature/games/usecase/games_fetch_games_usecase.dart';

class GamesProvider extends ChangeNotifier {
  final String preferredPlatform = Platforms.preferred;

  final GamesFetchGamesUsecase _getGames;

  GamesProvider({
    GamesRepository? repo,
    GamesFetchGamesUsecase? getGames,
  }) : _getGames = getGames ??
            GamesFetchGamesUsecaseImpl(repo ?? GamesRepositoryImpl());

  Future<List<Game>> fetchGames({int? page}) async {
    final games = await _getGames(page ?? 1, preferredPlatform);
    return games;
  }
}
