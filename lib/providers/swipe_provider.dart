import 'package:flutter/cupertino.dart';

class SwipeProvider extends ChangeNotifier {
  bool isRightSelected = false;
  bool get getIsRightSelected => isRightSelected;
  bool isLeftSelected = false;
  bool get getIsLeftSelected => isLeftSelected;

  void setSelection(String side) {
    if (side == 'right') {
      isRightSelected = true;
    } else {
      isLeftSelected = true;
    }
    notifyListeners();
  }

  void clearSelection() {
    isLeftSelected = false;
    isRightSelected = false;
    notifyListeners();
  }
}
