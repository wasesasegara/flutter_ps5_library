import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    super.key,
    required this.rating,
  });

  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('RatingWidget-$rating'),
      padding: const EdgeInsets.all(4),
      color: ratingColor(rating),
      child: Text(
        rating.toString(),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
      ),
    );
  }
}

Color ratingColor(double rating) {
  if (rating > 3) return const Color.fromARGB(255, 74, 157, 77);
  if (rating > 2) return const Color.fromARGB(255, 195, 117, 0);
  return const Color.fromARGB(255, 181, 41, 31);
}
