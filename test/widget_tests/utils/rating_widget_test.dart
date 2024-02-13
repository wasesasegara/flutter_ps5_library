import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/utils/widget/rating_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('RatingWidget test 5', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RatingWidget(rating: 5)));
    expect(find.text('5.0'), findsOneWidget);
  });
  testWidgets('RatingWidget test 3', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RatingWidget(rating: 3)));
    expect(find.text('3.0'), findsOneWidget);
  });
  testWidgets('RatingWidget test 2', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: RatingWidget(rating: 2)));
    expect(find.text('2.0'), findsOneWidget);
  });
}
