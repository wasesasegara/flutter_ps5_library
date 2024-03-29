import 'dart:convert';

import 'package:flutter_ps5_library/api/api_config.dart';
import 'package:flutter_ps5_library/data/games/model/game_model.dart';
import 'package:flutter_ps5_library/utils/config.dart';
import 'package:http/http.dart' as http;

Future<GameModel> apiGetGameDetails(String id, {http.Client? client}) async {
  final uri = Uri.https(Endpoints.rawg, '/api/games/$id', {
    if (!Config.isTest) 'key': ApiKeys.rawg,
  });
  final response = await (client ?? http.Client()).get(uri);
  if (response.statusCode != 200) {
    throw Exception(
      'Failed to load game details\n'
      'code: ${response.statusCode}\n'
      '${response.body}',
    );
  }
  final json = jsonDecode(response.body);
  return GameModel.fromJson(json);
}
