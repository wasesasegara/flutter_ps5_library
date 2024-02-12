class Game {
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

  String get bgImageUrl =>
      backgroundImage ?? shortScreenshots.firstOrNull?.image ?? '';

  Game({
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
}

class Screenshot {
  final String image;

  Screenshot({
    required this.image,
  });
}

class GamePlatformMetacritic {
  final int? metascore;
  final String? url;

  GamePlatformMetacritic({
    required this.metascore,
    required this.url,
  });
}
