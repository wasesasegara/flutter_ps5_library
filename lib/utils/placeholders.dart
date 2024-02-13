import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ContentPlaceholder extends StatelessWidget {
  final int numLines;

  const ContentPlaceholder({
    super.key,
    required this.numLines,
  });

  @override
  Widget build(BuildContext context) {
    final lines = max(2, numLines);
    return LayoutBuilder(builder: (context, cons) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < lines; i++) ...[
            if (i != 0) const SizedBox(height: 8),
            if (i != lines - 1)
              _textShimmer(_randomW(cons.maxWidth))
            else
              _textShimmer(100 + Random().nextDouble() * cons.maxWidth * 0.2),
          ]
        ],
      );
    });
  }
}

double _randomW(double maxW) {
  return maxW - Random().nextDouble() * maxW * 0.2;
}

Shimmer _textShimmer(double width) {
  return Shimmer.fromColors(
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
