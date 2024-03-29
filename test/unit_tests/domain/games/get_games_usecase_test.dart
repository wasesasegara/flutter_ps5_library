import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_games_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../mocks/game_mocks.dart';

class MockGamesRepository extends Mock implements GamesRepository {
  @override
  Future<List<Game>> getGames({
    required int page,
    required String platforms,
    http.Client? client,
  }) async {
    return [game1];
  }
}

void main() {
  final mockRepo = MockGamesRepository();
  final GetGamesUsecase sut = GetGamesUsecaseImpl(repo: mockRepo);
  test('GetGamesUsecase test', () async {
    final games = await sut(1, '123');
    expect(games, [game1]);
  });
}
