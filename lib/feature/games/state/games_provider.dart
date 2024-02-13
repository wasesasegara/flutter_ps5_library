import 'package:flutter/foundation.dart';
import 'package:flutter_ps5_library/api/api_config.dart';
import 'package:flutter_ps5_library/feature/games/state/games_state.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_games_usecase.dart';

class GamesProvider extends ChangeNotifier {
  final String _preferredPlatform = Platforms.preferred;

  final GamesState state = GamesState();

  final GetGamesUsecase _getGames;

  GamesProvider({
    GetGamesUsecase? getGames,
  }) : _getGames = getGames ?? GetGamesUsecaseImpl();

  Future<void> fetchGames({int? page}) async {
    if (state.isFetching) return;
    state.isFetching = true;
    state.hasMorePage = true;
    notifyListeners();
    state.errMsg = '';
    try {
      final games = await _getGames(page ?? state.page + 1, _preferredPlatform);
      if (page == 1) {
        state.games = games;
        state.page = 1;
      } else {
        state.page += 1;
        state.games.addAll(games);
      }
      if (games.isEmpty) state.hasMorePage = false;
    } catch (e) {
      state.errMsg = e.toString();
    }
    state.isFirstFetch = false;
    state.isFetching = false;
    notifyListeners();
  }
}
