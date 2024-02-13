import 'package:flutter_ps5_library/feature/game_details/state/game_details_state.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/game_mocks.dart';

void main() {
  test('GameDetailsState reset test', () {
    final sut = GameDetailsState();
    sut.errMsg = '';
    sut.isFetching = true;
    sut.isFirstFetch = false;
    sut.game = game1;
    sut.reset();
    expect(sut.isFirstFetch, true);
    expect(sut.isFetching, false);
    expect(sut.game, null);
    expect(sut.errMsg, '');
  });
}
