import 'package:flutter_ps5_library/api/api/api_get_games.dart';
import 'package:flutter_ps5_library/feature/games/domain/data/games_repository.dart';
import 'package:flutter_ps5_library/feature/games/domain/entity/game.dart';

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
