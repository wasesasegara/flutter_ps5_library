import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';

abstract class GamesFetchGamesUsecase {
  Future<List<Game>> call(int page, String platforms);
}

class GamesFetchGamesUsecaseImpl implements GamesFetchGamesUsecase {
  final GamesRepository repo;

  GamesFetchGamesUsecaseImpl(this.repo);

  @override
  Future<List<Game>> call(int page, String platforms) =>
      repo.fetchGames(page: page, platforms: platforms);
}
