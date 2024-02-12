import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';

abstract class GetGameDetailsUsecase {
  Future<Game> call(String id);
}

class GetGameDetailsUsecaseImpl implements GetGameDetailsUsecase {
  final GamesRepository repo;

  GetGameDetailsUsecaseImpl(this.repo);

  @override
  Future<Game> call(String id) => repo.getGameDetails(id);
}
