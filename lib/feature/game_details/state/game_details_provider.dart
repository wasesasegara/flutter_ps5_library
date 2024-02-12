import 'package:flutter/foundation.dart';
import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_game_details_usecase.dart';

class GameDetailsProvider extends ChangeNotifier {
  final GetGameDetailsUsecase _getGame;

  GameDetailsProvider({
    GamesRepository? repo,
    GetGameDetailsUsecase? getGame,
  }) : _getGame =
            getGame ?? GetGameDetailsUsecaseImpl(repo ?? GamesRepositoryImpl());

  Future<Game> fetchGame(String id) => _getGame(id);
}
