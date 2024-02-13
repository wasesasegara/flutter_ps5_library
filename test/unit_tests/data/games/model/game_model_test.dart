import 'package:flutter_ps5_library/data/games/model/game_model.dart';
import 'package:flutter_ps5_library/domain/games/entity/developer.dart';
import 'package:flutter_ps5_library/domain/games/entity/game_platform_metacritic.dart';
import 'package:flutter_ps5_library/domain/games/entity/platform.dart';
import 'package:flutter_ps5_library/domain/games/entity/screenshot.dart';
import 'package:flutter_test/flutter_test.dart';

final _dev1 = Developer(
  id: 1,
  name: 'name',
  slug: 'slug',
);

final _meta1 = GamePlatformMetacritic(
  metascore: 1,
  url: null,
);

final _plat1 = Platform(id: 1, name: null, imageBackground: null);

final _ss1 = Screenshot(image: 'image');

void main() {
  test('GameModel toEntity test', () {
    final sut = GameModel(
      id: 1,
      slug: 'slug',
      name: 'name',
      nameOriginal: 'nameOriginal',
      description: 'description',
      metacritic: 1,
      metacriticPlatforms: [_meta1],
      tba: true,
      updated: null,
      backgroundImage: 'backgroundImage',
      website: 'website',
      rating: 1.0,
      playtime: 1,
      shortScreenshots: [_ss1],
      released: 'released',
      developers: [_dev1],
      platforms: [_plat1],
    );
    final g = sut.toEntity();
    expect(g.id, 1);
    expect(g.slug, 'slug');
    expect(g.name, 'name');
    expect(g.nameOriginal, 'nameOriginal');
    expect(g.description, 'description');
    expect(g.metacritic, 1);
    expect(g.metacriticPlatforms[0], _meta1);
    expect(g.tba, true);
    expect(g.updated, null);
    expect(g.backgroundImage, 'backgroundImage');
    expect(g.website, 'website');
    expect(g.rating, 1.0);
    expect(g.playtime, 1);
    expect(g.shortScreenshots[0], _ss1);
    expect(g.released, 'released');
    expect(g.developers, []);
    expect(g.platforms[0], _plat1);
    expect(g.developers[0], _dev1);
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
      'updated': null,
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
    expect(sut.updated, null);
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
