import 'package:flutter/material.dart';

class GamesItemMoreWidget extends StatelessWidget {
  const GamesItemMoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, cons) {
      return Container(
        color: Theme.of(context).primaryColor.withOpacity(0.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.games),
            const SizedBox(height: 8),
            SizedBox(
              width: cons.maxWidth * 0.4,
              child: const LinearProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Give me more...!',
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      );
    });
  }
}
