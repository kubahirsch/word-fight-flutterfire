import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wordfight/models/question.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

Future<String> createNewWord(Question questionData) async {
  String res = 'Some error occured';

  try {
    await _firestore
        .collection(questionData.gameType)
        .doc(questionData.word)
        .set(questionData.toJson());
    res = 'success';
  } catch (e) {
    res = e.toString();
  }
  return res;
}
