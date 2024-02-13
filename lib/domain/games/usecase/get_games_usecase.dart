import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';

abstract class GetGamesUsecase {
  Future<List<Game>> call(int page, String platforms);
}

class GetGamesUsecaseImpl implements GetGamesUsecase {
  final GamesRepository _repo;

  GetGamesUsecaseImpl({GamesRepository? repo})
      : _repo = repo ?? GamesRepositoryImpl();

  @override
  Future<List<Game>> call(int page, String platforms) =>
      _repo.getGames(page: page, platforms: platforms);
}
