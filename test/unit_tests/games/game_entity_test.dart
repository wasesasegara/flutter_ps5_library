import 'package:flutter_ps5_library/domain/games/entity/game.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Game updatedWith test', () {
    final g = Game(
        id: 0,
        name: 'game-name',
        slug: null,
        nameOriginal: null,
        description: null,
        metacritic: null,
        metacriticPlatforms: [],
        tba: true,
        updated: DateTime(2024),
        backgroundImage: 'backgroundImage',
        website: null,
        rating: 4,
        playtime: 0,
        shortScreenshots: [],
        released: 'released');
    final ug = Game(
      id: 0,
      name: 'game-name',
      slug: 's',
      nameOriginal: 'no',
      description: 'desc',
      metacritic: null,
      metacriticPlatforms: [],
      tba: true,
      updated: DateTime(2024),
      backgroundImage: 'backgroundImage',
      website: null,
      rating: 0,
      playtime: 0,
      shortScreenshots: [],
      released: null,
    );
    final modifiedGame = g.updatedWith(ug);
    expect(modifiedGame.name, equals(ug.name));
    expect(modifiedGame.slug, equals(ug.slug));
    expect(modifiedGame.nameOriginal, equals(ug.nameOriginal));
    expect(modifiedGame.description, equals(ug.description));
    expect(modifiedGame.metacritic, equals(ug.metacritic));
    expect(modifiedGame.metacriticPlatforms, equals(ug.metacriticPlatforms));
    expect(modifiedGame.tba, equals(ug.tba));
    expect(modifiedGame.updated, equals(ug.updated));
    expect(modifiedGame.backgroundImage, equals(ug.backgroundImage));
    expect(modifiedGame.website, equals(ug.website));
    expect(modifiedGame.rating, equals(g.rating));
    expect(modifiedGame.playtime, equals(ug.playtime));
    expect(modifiedGame.shortScreenshots, equals(ug.shortScreenshots));
    expect(modifiedGame.released, equals(g.released));
  });
}
