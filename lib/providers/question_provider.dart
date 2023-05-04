import 'package:flutter/foundation.dart';
import 'package:wordfight/resources/question_methods.dart';

class QuestionProvider extends ChangeNotifier {
  Map<String, dynamic>? questionDataAsMap;
  Map<String, dynamic> get getQuestionDataAsMap => questionDataAsMap!;
  int points = 0;
  int get getPoints => points;

  void changePoints(int newPoints) {
    points += newPoints;
  }

  void zeroPoints() {
    points = 0;
  }

  Future<void> setQuestionDataInProvider(
      int questionId, String gameType) async {
    questionDataAsMap =
        await QuestionMethods().getQuestion(questionId, gameType);
    notifyListeners();
  }
}
