import 'package:flutter_ps5_library/api/api_config.dart';
import 'package:flutter_ps5_library/api/games/api_get_game_details.dart';
import 'package:flutter_ps5_library/utils/config.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

import '../../mocks/http_client.mocks.dart';

void main() {
  Config.isTest = true;
  test('apiGetGameDetails test', () async {
    final client = MockClient();
    when(client.get(Uri.https(Endpoints.rawg, '/api/games/1', {}))).thenAnswer(
        (_) async => http.Response(
            '{"id": 1, "name": "mock", "rating": 4.0, "playtime": 0}', 200));
    final res = await apiGetGameDetails('1', client: client);
    expect(res.id, 1);
  });
}
