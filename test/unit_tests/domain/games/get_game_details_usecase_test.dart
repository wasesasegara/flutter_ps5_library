import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_game_details_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockGamesRepository extends Mock implements GamesRepository {
  @override
  Future<Game> getGameDetails(String id, {http.Client? client}) async {
    return game1;
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
  final GetGameDetailsUsecase sut = GetGameDetailsUsecaseImpl(mockRepo);
  test('GetGameDetailsUsecase test', () async {
    final game = await sut('123');
    expect(game, game1);
  });
}
