import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:wordfight/resources/firestore_methods.dart';

class GameProvider extends ChangeNotifier {
  int roundNumber = 1;
  int get getRoundNumber => roundNumber;
  int myPoints = 0;
  int get getMyPoints => myPoints;
  int rivalPoints = 0;
  int get getRivalPoints => rivalPoints;

  String? userId;
  String get getUserId => userId!;
  String? rivalId;
  String get getRivalId => rivalId!;
  String? myGame;
  String? get getMyGame => myGame;
  List<dynamic> questions = [];
  List<dynamic> get getQuestions => questions;
  String? myUsername;
  String get getMyUsername => myUsername!;
  String? rivalUsername;
  String get getRivalUsername => rivalUsername!;
  String? gameType;
  String get getGameType => gameType!;

  Map<String, dynamic>? gameSnap;
  Map<String, dynamic>? get getGameSnap => gameSnap;

  void setUserId(String userIdf) {
    userId = userIdf;

    notifyListeners();
  }

  void setGameId(String? userIdInput) {
    myGame = userIdInput;

    notifyListeners();
  }

  void setMyUsername(String myUsernameInput) {
    myUsername = myUsernameInput;

    notifyListeners();
  }

  void increaseRoundNumber() {
    roundNumber += 1;
  }

  void setGameType(String gameTypeInput) {
    gameType = gameTypeInput;

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
    roundNumber = gameSnap!['round_$userId'];
    notifyListeners();
  }
}
