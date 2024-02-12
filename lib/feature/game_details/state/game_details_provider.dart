import 'package:flutter/foundation.dart';
import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_game_details_usecase.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_state.dart';

class GameDetailsProvider extends ChangeNotifier {
  final GameDetailsState state = GameDetailsState();

  final GetGameDetailsUsecase _getGame;

  GameDetailsProvider({
    GamesRepository? repo,
    GetGameDetailsUsecase? getGame,
  }) : _getGame =
            getGame ?? GetGameDetailsUsecaseImpl(repo ?? GamesRepositoryImpl());

  Future<void> fetchGame(String id) async {
    if (state.isFetching) return;
    state.isFetching = true;
    notifyListeners();
    state.errMsg = '';
    try {
      state.game = await _getGame(id);
    } catch (e) {
      state.errMsg = e.toString();
    }
    state.isFirstFetch = false;
    state.isFetching = false;
    notifyListeners();
  }
}
