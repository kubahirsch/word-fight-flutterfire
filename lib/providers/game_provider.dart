import 'package:flutter/material.dart';

import '../resources/firestore_methods.dart';

class GameProvider extends ChangeNotifier {
  int roundNumber = 1;
  int get getRoundNumber => roundNumber;

  void increaseRoundNumber() {
    roundNumber += 1;
  }
}
