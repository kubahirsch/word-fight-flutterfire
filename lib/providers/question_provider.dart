import 'package:flutter/foundation.dart';
import 'package:wordfight/resources/question_methods.dart';

class QuestionProvider extends ChangeNotifier {
  Map<String, dynamic>? questionDataAsMap;

  Map<String, dynamic> get getQuestionDataAsMap => questionDataAsMap!;

  Future<void> setQuestionDataInProvider(int questionId) async {
    questionDataAsMap = await QuestionMethods().getRandomQuestion(questionId);
    notifyListeners();
  }
}
