import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_games_usecase.dart';
import 'package:flutter_ps5_library/feature/games/state/games_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/game_mocks.dart';

class GetGamesUseCaseMock extends Mock implements GetGamesUsecase {
  @override
  Future<List<Game>> call(
    int page,
    String platforms,
  ) async {
    return [game1];
  }
}

void main() {
  test('GamesProvider test', () async {
    final mockGetGames = GetGamesUseCaseMock();
    final sut = GamesProvider(getGames: mockGetGames);
    await sut.fetchGames(page: 1);
    expect(sut.state.games[0], game1);
  });
}
