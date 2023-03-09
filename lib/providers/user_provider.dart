import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wordfight/resources/firestore_methods.dart';

class UserProvider extends ChangeNotifier {
  String? userId;
  String get getUserId => userId!;
  String? rivalId;
  String get getRivalId => rivalId!;
  String? myGame;
  String get getMyGame => myGame!;
  List<dynamic> questions = [];
  List<dynamic> get getQuestions => questions;

  Map<String, dynamic>? gameSnap;
  Map<String, dynamic>? get getGameSnap => gameSnap;

  void setUserId(String userIdf) {
    userId = userIdf;

    notifyListeners();
  }

  Future<void> refreshGameDataInProvider(String gameId) async {
    gameSnap = await FirestoreMethods().getGameSnapAsMap(gameId);
    List allUserId = [gameSnap!['userId1'], gameSnap!['userId2']];
    allUserId.remove(userId);
    myGame = gameSnap!['gameId'];
    rivalId = allUserId.join();
    questions = gameSnap!['questionsIds'];

    notifyListeners();
  }
}
