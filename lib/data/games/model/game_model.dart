import 'package:flutter_ps5_library/domain/games/entity/game.dart';

class GameModel {
  final int? id;
  final String? slug;
  final String? name;
  final String? nameOriginal;
  final String? description;
  final int? metacritic;
  final List<GamePlatformMetacritic> metacriticPlatforms;
  final bool? tba;
  final DateTime? updated;
  final String? backgroundImage;
  final String? website;
  final double rating;

  /// In hours
  final int playtime;
  final List<Screenshot> shortScreenshots;
  final String? released;

  GameModel({
    required this.id,
    required this.slug,
    required this.name,
    required this.nameOriginal,
    required this.description,
    required this.metacritic,
    required this.metacriticPlatforms,
    required this.tba,
    required this.updated,
    required this.backgroundImage,
    required this.website,
    required this.rating,
    required this.playtime,
    required this.shortScreenshots,
    required this.released,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      slug: json['slug'],
      name: json['name'],
      nameOriginal: json['name_original'],
      description: json['description'],
      metacritic: json['metacritic'],
      metacriticPlatforms: json['metacritic_platforms'] is List
          ? (json['metacritic_platforms'] as List)
              .map((e) => GamePlatformMetacritic(
                  metascore: e['metascore'], url: e['url']))
              .toList()
          : [],
      tba: json['tba'],
      updated: DateTime.tryParse(json['updated'] ?? '')?.toLocal(),
      backgroundImage: json['background_image'],
      website: json['website'],
      rating: json['rating'],
      playtime: json['playtime'],
      released: json['released'],
      shortScreenshots: json['short_screenshots'] is List
          ? (json['short_screenshots'] as List)
              .map((e) => Screenshot(image: e['image']))
              .toList()
          : [],
    );
  }

  Game toEntity() {
    return Game(
      id: id,
      slug: slug,
      name: name,
      nameOriginal: nameOriginal,
      description: description,
      metacritic: metacritic,
      metacriticPlatforms: metacriticPlatforms,
      tba: tba,
      updated: updated,
      backgroundImage: backgroundImage,
      website: website,
      rating: rating,
      playtime: playtime,
      shortScreenshots: shortScreenshots,
      released: released,
    );
  }
}
