import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_games_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

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

final game1 = Game(
  id: 1,
  slug: null,
  name: 'game1',
  nameOriginal: null,
  description: null,
  metacritic: null,
  metacriticPlatforms: [],
  tba: null,
  updated: null,
  backgroundImage: null,
  website: null,
  rating: 0,
  playtime: 0,
  shortScreenshots: [],
  released: null,
  developers: [],
  platforms: [],
);

void main() {
  final mockRepo = MockGamesRepository();
  final GetGamesUsecase sut = GetGamesUsecaseImpl(repo: mockRepo);
  test('GetGamesUsecase test', () async {
    final games = await sut(1, '123');
    expect(games, [game1]);
  });
}
