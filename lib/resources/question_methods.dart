import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  Future<Map<String, dynamic>> getQuestion(
      int questionId, String gameType) async {
    QuerySnapshot questionQuery = await _firestore
        .collection(gameType)
        .where('id', isEqualTo: questionId)
        .limit(1)
        .get();
    DocumentSnapshot questionSnap = questionQuery.docs[0];

    return questionSnap.data() as Map<String, dynamic>;
  }

  Future<void> addingPointsToDatabase(
      String userId, String gameId, int numOfPoints) async {
    await _firestore.collection('games').doc(gameId).update({
      'points_$userId': FieldValue.increment(numOfPoints),
    });
  }
}
