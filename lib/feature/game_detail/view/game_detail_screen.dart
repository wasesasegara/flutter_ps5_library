import 'package:flutter/material.dart';

class GameDetailScreen extends StatefulWidget {
  static String routeName = 'game-detail';

  final String? id;
  final String? title;

  const GameDetailScreen({super.key, required this.id, this.title});

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
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
