import 'package:flutter_ps5_library/api/games/api_get_games.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';

abstract class GamesRepository {
  Future<List<Game>> fetchGames({required int page, required String platforms});
}

class GamesRepositoryImpl implements GamesRepository {
  @override
  Future<List<Game>> fetchGames({
    required int page,
    required String platforms,
  }) async {
    final response = await apiGetGames(GetGamesParams(
      page: page,
      pageSize: 20,
      platforms: platforms,
    ));
    return response.map((e) => e.toEntity()).toList();
  }
}
