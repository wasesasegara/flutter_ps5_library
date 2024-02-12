import 'package:flutter_ps5_library/api/games/api_get_game_details.dart';
import 'package:flutter_ps5_library/api/games/api_get_games.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';

abstract class GamesRepository {
  Future<Game> getGameDetails(String id);
  Future<List<Game>> getGames({required int page, required String platforms});
}

class GamesRepositoryImpl implements GamesRepository {
  @override
  Future<Game> getGameDetails(String id) async {
    final res = await apiGetGameDetails(id);
    return res.toEntity();
  }

  @override
  Future<List<Game>> getGames({
    required int page,
    required String platforms,
  }) async {
    final res = await apiGetGames(GetGamesParams(
      page: page,
      pageSize: 20,
      platforms: platforms,
    ));
    return res.map((e) => e.toEntity()).toList();
  }
}
