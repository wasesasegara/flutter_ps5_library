import 'package:flutter_ps5_library/feature/games/domain/entity/game.dart';

class GamesState {
  bool isFetching = false;
  List<Game> games = [];
  bool hasMorePage = true;
  String errMsg = '';

  void reset() {
    isFetching = false;
    games = [];
    hasMorePage = true;
    errMsg = '';
  }
}
