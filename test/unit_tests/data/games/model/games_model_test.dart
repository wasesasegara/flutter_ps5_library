import 'package:flutter_ps5_library/data/games/model/games_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('GamesModel fromJson test', () {
    final json = {
      'count': 1,
      'next': 'next',
      'previous': 'previous',
      'results': [
        {
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
        },
      ],
    };
    final sut = GamesModel.fromJson(json);
    expect(sut.results.length, 1);
    expect(sut.results[0].id, 1);
    expect(sut.results[0].slug, 'slug');
    expect(sut.results[0].name, 'name');
    expect(sut.results[0].nameOriginal, 'nameOriginal');
    expect(sut.results[0].description, 'description');
    expect(sut.results[0].metacritic, 1);
    expect(sut.results[0].metacriticPlatforms, []);
    expect(sut.results[0].tba, true);
    expect(sut.results[0].updated, DateTime.now());
    expect(sut.results[0].backgroundImage, 'backgroundImage');
    expect(sut.results[0].website, 'website');
    expect(sut.results[0].rating, 1.0);
    expect(sut.results[0].playtime, 1);
    expect(sut.results[0].shortScreenshots, []);
    expect(sut.results[0].released, 'released');
    expect(sut.results[0].developers, []);
    expect(sut.results[0].platforms, []);
  });

  test('GamesModel fromJson empty test', () {
    final json = {
      'count': 1,
      'next': 'next',
      'previous': 'previous',
      'results': [],
    };
    final sut = GamesModel.fromJson(json);
    expect(sut.results.length, 0);
  });
}
