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
  final List<Screenshot> shortScreenshots;

  GameModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.released,
    required this.backgroundImage,
    required this.shortScreenshots,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      released: json['released'],
      backgroundImage: json['background_image'],
      shortScreenshots: json['short_screenshots'] is List
          ? (json['short_screenshots'] as List)
              .map((e) => Screenshot.fromJson(e))
              .toList()
          : [],
    );
  }

  Game toEntity() {
    return Game(
      id: id,
      name: name,
      slug: slug,
      released: released,
      backgroundImage: backgroundImage,
      shortScreenshots: shortScreenshots.map((e) => e.image).toList(),
    );
  }
}

class Screenshot {
  final String image;

  Screenshot({
    required this.image,
  });

  factory Screenshot.fromJson(Map<String, dynamic> json) {
    return Screenshot(
      image: json['image'],
    );
  }
}
