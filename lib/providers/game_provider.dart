import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  int roundNumber = 1;
  int get getRoundNumber => roundNumber;
  int myPoints = 0;
  int get getMyPoints => myPoints;
  int rivalPoints = 0;
  int get getRivalPoints => rivalPoints;

  void increaseRoundNumber() {
    roundNumber += 1;
  }
}
