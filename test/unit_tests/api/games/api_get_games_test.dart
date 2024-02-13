import 'package:flutter_ps5_library/api/api_config.dart';
import 'package:flutter_ps5_library/api/games/api_get_games.dart';
import 'package:flutter_ps5_library/utils/config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../mocks/http_client.mocks.dart';

void main() {
  Config.isTest = true;
  test('apiGetGames test', () async {
    final client = MockClient();
    when(client.get(
        Uri.https(Endpoints.rawg, '/api/games',
            {}))).thenAnswer((_) async => http.Response(
        '{"results": [{"id": 1, "name": "mock", "rating": 4.0, "playtime": 0}]}',
        200));
    final res = await apiGetGames(
        GetGamesParams(
          page: 1,
          pageSize: 20,
          platforms: '123',
        ),
        client: client);
    expect(res[0].id, 1);
  });
  test('GetGamesParams test', () async {
    final sut = GetGamesParams(page: 1, pageSize: 20, platforms: '123');
    final map = sut.toMap();
    expect(map['page'], '1');
    expect(map['page_size'], '20');
    expect(map['platforms'], '123');
  });
}
