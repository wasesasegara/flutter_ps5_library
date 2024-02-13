import 'package:flutter/material.dart';
import 'package:flutter_ps5_library/utils/widget/text_placeholder_widget.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('TextPlaceholderWidget numLines under 1', (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: TextPlaceholderWidget(numLines: 0)));
    expect(find.byKey(const ValueKey('TextPlaceholderWidget-shimmer-0')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('TextPlaceholderWidget-shimmer-1')),
        findsNothing);
  });
  testWidgets('TextPlaceholderWidget test', (tester) async {
    await tester.pumpWidget(
        const MaterialApp(home: TextPlaceholderWidget(numLines: 4)));
    expect(find.byKey(const ValueKey('TextPlaceholderWidget-shimmer-0')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('TextPlaceholderWidget-shimmer-1')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('TextPlaceholderWidget-shimmer-2')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('TextPlaceholderWidget-shimmer-3')),
        findsOneWidget);
    expect(find.byKey(const ValueKey('TextPlaceholderWidget-shimmer-4')),
        findsNothing);
  });
}
