import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TextPlaceholderWidget extends StatelessWidget {
  final int numLines;

  const TextPlaceholderWidget({
    super.key,
    required this.numLines,
  });

  @override
  Widget build(BuildContext context) {
    final lines = max(1, numLines);
    return LayoutBuilder(builder: (context, cons) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < lines; i++) ...[
            if (i != 0) const SizedBox(height: 8),
            if (i != lines - 1)
              _textShimmer(_randomW(cons.maxWidth), index: i)
            else
              _textShimmer(100 + Random().nextDouble() * cons.maxWidth * 0.2,
                  index: i),
          ]
        ],
      );
    });
  }
}

double _randomW(double maxW) {
  return maxW - Random().nextDouble() * maxW * 0.2;
}

Shimmer _textShimmer(double width, {required int index}) {
  return Shimmer.fromColors(
    key: Key('TextPlaceholderWidget-shimmer-$index'),
    baseColor: Colors.grey,
    highlightColor: Colors.white,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey,
      ),
      width: width,
      height: 14,
    ),
  );
}
