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
  String? myUsername;
  String get getMyUsername => myUsername!;
  String? rivalUsername;
  String get getRivalUsername => rivalUsername!;

  Map<String, dynamic>? gameSnap;
  Map<String, dynamic>? get getGameSnap => gameSnap;

  void setUserId(String userIdf) {
    userId = userIdf;

    notifyListeners();
  }

  void setMyUsername(String myUsernamef) {
    myUsername = myUsernamef;

    notifyListeners();
  }

  Future<void> refreshGameDataInProvider(String gameId) async {
    gameSnap = await FirestoreMethods().getGameSnapAsMap(gameId);
    // setting rival id
    List allUserId = [gameSnap!['userId1'], gameSnap!['userId2']];
    allUserId.remove(userId);
    rivalId = allUserId.join();
    //setting rival username
    List allUsernames = [gameSnap!['username1'], gameSnap!['username2']];
    allUsernames.remove(myUsername);
    rivalUsername = allUsernames.join();
    myGame = gameSnap!['gameId'];

    questions = gameSnap!['questionsIds'];

    notifyListeners();
  }
}
