import 'package:flutter_ps5_library/feature/games/domain/entity/game.dart';

abstract class GamesRepository {
  Future<List<Game>> fetchGames({required int page, required String platforms});
}
