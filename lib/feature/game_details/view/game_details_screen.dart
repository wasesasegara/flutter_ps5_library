import 'package:flutter/material.dart';

class GameDetailsScreen extends StatefulWidget {
  static String routeName = 'game-detail';

  final String? id;
  final String? title;

  const GameDetailsScreen({super.key, required this.id, this.title});

  @override
  State<GameDetailsScreen> createState() => _GameDetailsScreenState();
}

class _GameDetailsScreenState extends State<GameDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? 'Game Detail')),
      body: body,
    );
  }

  Widget get body {
    if (widget.id?.isEmpty ?? true) {
      return const Center(child: Text('Game has no id!'));
    }
    return const Center(child: Text('Game Detail'));
  }
}
