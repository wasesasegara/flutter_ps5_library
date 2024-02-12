import 'package:flutter_ps5_library/domain/games/entity/game.dart';

class GameDetailsState {
  bool isFirstFetch = true;
  bool isFetching = false;
  Game? game;
  String errMsg = '';

  void reset() {
    isFirstFetch = true;
    isFetching = false;
    game = null;
    errMsg = '';
  }
}
