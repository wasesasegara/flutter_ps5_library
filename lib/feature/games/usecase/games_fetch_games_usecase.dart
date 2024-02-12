import 'package:flutter_ps5_library/feature/games/domain/data/games_repository.dart';
import 'package:flutter_ps5_library/feature/games/domain/entity/game.dart';

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
