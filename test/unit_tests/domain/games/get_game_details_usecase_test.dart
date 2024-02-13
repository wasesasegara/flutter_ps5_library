import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_game_details_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../mocks/game_mocks.dart';

class MockGamesRepository extends Mock implements GamesRepository {
  @override
  Future<Game> getGameDetails(String id, {http.Client? client}) async {
    return game1;
  }
}

void main() {
  final mockRepo = MockGamesRepository();
  final GetGameDetailsUsecase sut = GetGameDetailsUsecaseImpl(repo: mockRepo);
  test('GetGameDetailsUsecase test', () async {
    final game = await sut('123');
    expect(game, game1);
  });
}
