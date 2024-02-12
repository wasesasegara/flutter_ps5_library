import 'package:flutter_ps5_library/feature/games/domain/entity/game.dart';

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

class GameModel {
  final int id;
  final String name;
  final String slug;
  final String released;
  final String? backgroundImage;

  GameModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.released,
    required this.backgroundImage,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      released: json['released'],
      backgroundImage: json['background_image'],
    );
  }

  Game toEntity() {
    return Game(
      id: id,
      name: name,
      slug: slug,
      released: released,
      backgroundImage: backgroundImage,
    );
  }
}
