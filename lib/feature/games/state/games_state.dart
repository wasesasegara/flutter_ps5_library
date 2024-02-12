import 'package:flutter_ps5_library/domain/games/entity/game.dart';

class GamesState {
  bool isFirstFetch = true;
  bool isFetching = false;
  List<Game> games = [];
  int page = 1;
  bool hasMorePage = true;
  String errMsg = '';
}
