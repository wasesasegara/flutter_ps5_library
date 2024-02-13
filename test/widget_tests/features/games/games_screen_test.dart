import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/games/state/games_provider.dart';
import 'package:flutter_ps5_library/feature/games/state/games_state.dart';
import 'package:flutter_ps5_library/feature/games/view/games_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../unit_tests/mocks/game_mocks.dart';

final _state = GamesState();

class MockGamesProvider extends Mock implements GamesProvider {
  @override
  GamesState get state => _state;

  @override
  Future<void> fetchGames({int? page}) async {
    state.games = [game1];
    state.isFirstFetch = false;
    notifyListeners();
  }
}

void main() {
  testWidgets('GamesScreen test', (tester) async {
    final GamesProvider mockGamesProvider = MockGamesProvider();
    await tester.pumpWidget(
      ChangeNotifierProvider<GamesProvider>.value(
        value: mockGamesProvider,
        child: const MaterialApp(
          home: GamesScreen(),
        ),
      ),
    );
    expect(find.text('Latest PS5 Games'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    // await mockGamesProvider.fetchGames();
    // await tester.pumpAndSettle();
    // expect(find.byType(GamesItemWidget), findsOneWidget);
    // expect(find.byType(GamesItemMoreWidget), findsOneWidget);
  });
}
