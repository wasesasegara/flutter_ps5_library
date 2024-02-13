import 'package:flutter_ps5_library/api/api_config.dart';
import 'package:flutter_ps5_library/data/games/games_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../mocks/http_client.mocks.dart';

void main() {
  final GamesRepository sut = GamesRepositoryImpl();
  test('GamesRepository getGameDetails test', () async {
    final client = MockClient();
    when(client.get(Uri.https(Endpoints.rawg, '/api/games/1', {}))).thenAnswer(
        (_) async => http.Response(
            '{"id": 1, "name": "mock", "rating": 4.0, "playtime": 0}', 200));
    final res = await sut.getGameDetails('1', client: client);
    expect(res.id, 1);
  });

  test('GamesRepository getGames test', () async {
    final client = MockClient();
    when(client.get(
        Uri.https(Endpoints.rawg, '/api/games',
            {}))).thenAnswer((_) async => http.Response(
        '{"results": [{"id": 1, "name": "mock", "rating": 4.0, "playtime": 0}]}',
        200));
    final res = await sut.getGames(page: 1, platforms: '123', client: client);
    expect(res[0].id, 1);
  });
}
