import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/feature/games/view/widget/games_item_more_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GamesItemMoreWidget test', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: GamesItemMoreWidget()));
    expect(find.byIcon(Icons.games), findsOneWidget);
    expect(find.text('Give me more...!'), findsOneWidget);
  });
}
