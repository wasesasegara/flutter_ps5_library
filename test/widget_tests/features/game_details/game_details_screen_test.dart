import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_provider.dart';
import 'package:flutter_ps5_library/feature/game_details/state/game_details_state.dart';
import 'package:flutter_ps5_library/feature/game_details/view/game_details_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../unit_tests/mocks/game_mocks.dart';

final _state = GameDetailsState();

class MockGameDetailsProvider extends Mock implements GameDetailsProvider {
  @override
  GameDetailsState get state => _state;

  @override
  Future<void> fetchGame(String id) async {
    state.game = game1;
    state.isFirstFetch = false;
    notifyListeners();
  }
}

void main() {
  testWidgets('GameDetailsScreen test', (tester) async {
    final GameDetailsProvider mockGameDetailsProvider =
        MockGameDetailsProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<GameDetailsProvider>.value(
        value: mockGameDetailsProvider,
        child: MaterialApp(
          home: GameDetailsScreen(
            id: '1',
            title: game1.name,
          ),
        ),
      ),
    );
  });
}
