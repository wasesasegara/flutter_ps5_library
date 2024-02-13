import 'package:flutter_ps5_library/data/games/model/game_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GameModel toEntity test', () {
    final sut = GameModel(
      id: 1,
      slug: 'slug',
      name: 'name',
      nameOriginal: 'nameOriginal',
      description: 'description',
      metacritic: 1,
      metacriticPlatforms: [],
      tba: true,
      updated: DateTime.now(),
      backgroundImage: 'backgroundImage',
      website: 'website',
      rating: 1.0,
      playtime: 1,
      shortScreenshots: [],
      released: 'released',
      developers: [],
      platforms: [],
    );
    final g = sut.toEntity();
    expect(g.id, 1);
    expect(g.slug, 'slug');
    expect(g.name, 'name');
    expect(g.nameOriginal, 'nameOriginal');
    expect(g.description, 'description');
    expect(g.metacritic, 1);
    expect(g.metacriticPlatforms, []);
    expect(g.tba, true);
    expect(g.updated, DateTime.now());
    expect(g.backgroundImage, 'backgroundImage');
    expect(g.website, 'website');
    expect(g.rating, 1.0);
    expect(g.playtime, 1);
    expect(g.shortScreenshots, []);
    expect(g.released, 'released');
    expect(g.developers, []);
    expect(g.platforms, []);
  });

  test('GameModel fromJson test', () {
    final json = {
      'id': 1,
      'slug': 'slug',
      'name': 'name',
      'name_original': 'nameOriginal',
      'description': 'description',
      'metacritic': 1,
      'metacritic_platforms': [],
      'tba': true,
      'updated': DateTime.now().toIso8601String(),
      'background_image': 'backgroundImage',
      'website': 'website',
      'rating': 1.0,
      'playtime': 1,
      'short_screenshots': [],
      'released': 'released',
      'developers': [],
      'platforms': [],
    };
    final sut = GameModel.fromJson(json);
    expect(sut.id, 1);
    expect(sut.slug, 'slug');
    expect(sut.name, 'name');
    expect(sut.nameOriginal, 'nameOriginal');
    expect(sut.description, 'description');
    expect(sut.metacritic, 1);
    expect(sut.metacriticPlatforms, []);
    expect(sut.tba, true);
    expect(sut.updated, DateTime.now());
    expect(sut.backgroundImage, 'backgroundImage');
    expect(sut.website, 'website');
    expect(sut.rating, 1.0);
    expect(sut.playtime, 1);
    expect(sut.shortScreenshots, []);
    expect(sut.released, 'released');
    expect(sut.developers, []);
    expect(sut.platforms, []);
  });
}
