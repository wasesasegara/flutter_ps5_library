import 'package:flutter_ps5_library/data/games/model/game_model.dart';

class GamesModel {
  final List<GameModel> results;

  GamesModel({
    required this.results,
  });

  factory GamesModel.fromJson(Map<String, dynamic> json) {
    return GamesModel(
      results: json['results'] is List
          ? (json['results'] as List).map((e) => GameModel.fromJson(e)).toList()
          : [],
    );
  }
}
