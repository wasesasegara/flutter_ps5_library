import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter_ps5_library/api/api_config.dart';
import 'package:flutter_ps5_library/api/model/games_model.dart';

Future<List<GameModel>> apiGetGames(GetGamesParams params) async {
  final uri = Uri.https(Endpoints.rawg, '/api/games', {
    'key': ApiKeys.rawg,
    ...params.toMap(),
  });
  final response = await http.get(uri);
  if (response.statusCode != 200) {
    throw Exception(
      'Failed to load games\n'
      'code: ${response.statusCode}\n'
      '${response.body}',
    );
  }
  final json = jsonDecode(response.body);
  return GamesModel.fromJson(json).results;
}

class GetGamesParams {
  final int page;
  final int pageSize;
  final String platforms;

  GetGamesParams({
    required this.page,
    required this.pageSize,
    required this.platforms,
  });

  Map<String, dynamic> toMap() {
    return {
      'page': page.toString(),
      'page_size': pageSize.toString(),
      'platforms': platforms,
    };
  }
}
