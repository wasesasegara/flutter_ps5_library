import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/feature/games/view/widget/games_item_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GamesItemWidget test', (tester) async {
    final g = Game(
      id: 0,
      name: 'game-name',
      slug: null,
      nameOriginal: null,
      description: null,
      metacritic: null,
      metacriticPlatforms: [],
      tba: true,
      updated: DateTime(2024),
      backgroundImage: 'backgroundImage',
      website: null,
      rating: 4,
      playtime: 0,
      shortScreenshots: [],
      released: 'released',
      developers: [],
      platforms: [],
    );
    await tester.pumpWidget(MaterialApp(
        home: GamesItemWidget(
      game: g,
      onTap: () {},
    )));
    expect(find.byIcon(Icons.image), findsOneWidget);
  });
}
