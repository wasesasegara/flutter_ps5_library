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

  Game updatedWith(Game g) {
    return Game(
      id: g.id ?? id,
      slug: g.slug ?? slug,
      name: g.name ?? name,
      nameOriginal: g.nameOriginal ?? nameOriginal,
      description: g.description ?? description,
      metacritic: g.metacritic ?? metacritic,
      metacriticPlatforms: g.metacriticPlatforms.isNotEmpty
          ? g.metacriticPlatforms
          : metacriticPlatforms,
      tba: g.tba ?? tba,
      updated: g.updated ?? updated,
      backgroundImage: g.backgroundImage ?? backgroundImage,
      website: g.website ?? website,
      rating: g.rating > 0 ? g.rating : rating,
      playtime: g.playtime > 0 ? g.playtime : playtime,
      shortScreenshots:
          g.shortScreenshots.isNotEmpty ? g.shortScreenshots : shortScreenshots,
      released: g.released ?? released,
    );
  }
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
