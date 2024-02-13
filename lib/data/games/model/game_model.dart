import 'package:flutter_ps5_library/domain/games/entity/developer.dart';
import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_ps5_library/domain/games/entity/game_platform_metacritic.dart';
import 'package:flutter_ps5_library/domain/games/entity/platform.dart';
import 'package:flutter_ps5_library/domain/games/entity/screenshot.dart';

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
  final List<Developer> developers;
  final List<Platform> platforms;

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
    required this.developers,
    required this.platforms,
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
      developers: json['developers'] is List
          ? (json['developers'] as List)
              .map((e) =>
                  Developer(id: e['id'], name: e['name'], slug: e['slug']))
              .toList()
          : [],
      platforms: json['platforms'] is List
          ? (json['platforms'] as List)
              .map((e) => Platform(
                  id: e['platform']['id'],
                  name: e['platform']['name'],
                  imageBackground: e['platform']['image_background']))
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
      developers: developers,
      platforms: platforms,
    );
  }
}
