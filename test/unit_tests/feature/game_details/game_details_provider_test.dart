import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/domain/games/usecase/get_game_details_usecase.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/game_mocks.dart';

class GetGameDetailsUseCaseMock extends Mock implements GetGameDetailsUsecase {
  @override
  Future<Game> call(String id) async {
    return game1;
  }
}

void main() {
  test('GameDetailsProvider test', () async {
    final getGameDetailsMock = GetGameDetailsUseCaseMock();
    final sut = GameDetailsProvider(getGame: getGameDetailsMock);
    await sut.fetchGame('123');
    expect(sut.state.game, game1);
  });
}
