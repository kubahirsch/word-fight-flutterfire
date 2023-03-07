import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class QuestionMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  Future<Map<String, dynamic>> getRandomQuestion() async {
    AggregateQuerySnapshot query =
        await _firestore.collection('questions').count().get();

    int numbersOdQuestions = query.count;

    QuerySnapshot questionQuery = await _firestore
        .collection('questions')
        .where('id', isGreaterThanOrEqualTo: random(0, numbersOdQuestions))
        .orderBy('id')
        .limit(1)
        .get();

    DocumentSnapshot questionSnap = questionQuery.docs[0];

    return questionSnap.data() as Map<String, dynamic>;
  }
}
