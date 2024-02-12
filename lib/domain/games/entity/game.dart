class Game {
  final int id;
  final String name;
  final String slug;
  final String released;
  final String? backgroundImage;
  final List<String> shortScreenshots;

  Game({
    required this.id,
    required this.name,
    required this.slug,
    required this.released,
    required this.backgroundImage,
    required this.shortScreenshots,
  });
}
