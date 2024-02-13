import 'package:flutter_ps5_library/api/games/api_get_game_details.dart';
import 'package:flutter_ps5_library/api/games/api_get_games.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:http/http.dart' as http;

abstract class GamesRepository {
  Future<Game> getGameDetails(String id, {http.Client? client});
  Future<List<Game>> getGames({
    required int page,
    required String platforms,
    http.Client? client,
  });
}

class GamesRepositoryImpl implements GamesRepository {
  @override
  Future<Game> getGameDetails(String id, {http.Client? client}) async {
    final res = await apiGetGameDetails(id, client: client);
    return res.toEntity();
  }

  @override
  Future<List<Game>> getGames(
      {required int page,
      required String platforms,
      http.Client? client}) async {
    final res = await apiGetGames(
      GetGamesParams(
        page: page,
        pageSize: 20,
        platforms: platforms,
      ),
      client: client,
    );
    return res.map((e) => e.toEntity()).toList();
  }
}
