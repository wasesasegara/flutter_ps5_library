import 'package:flutter/foundation.dart';
import 'package:flutter_ps5_library/api/api_config.dart';
import 'package:flutter_ps5_library/feature/games/data/games_repository_impl.dart';
import 'package:flutter_ps5_library/feature/games/domain/data/games_repository.dart';
import 'package:flutter_ps5_library/feature/games/state/games_state.dart';
import 'package:flutter_ps5_library/feature/games/usecase/games_fetch_games_usecase.dart';

class GamesProvider extends ChangeNotifier {
  final String _preferredPlatform = Platforms.preferred;

  final GamesState state = GamesState();

  final GamesFetchGamesUsecase _getGames;

  GamesProvider({
    GamesRepository? repo,
    GamesFetchGamesUsecase? getGames,
  }) : _getGames = getGames ??
            GamesFetchGamesUsecaseImpl(repo ?? GamesRepositoryImpl());

  Future<void> fetchGames({int? page}) async {
    if (state.isFetching) return;
    state.isFetching = true;
    state.hasMorePage = true;
    try {
      final games = await _getGames(page ?? 1, _preferredPlatform);
      state.games.addAll(games);
      if (games.isEmpty) state.hasMorePage = false;
    } catch (e) {
      state.errMsg = e.toString();
    }
    state.isFetching = false;
    notifyListeners();
  }
}
