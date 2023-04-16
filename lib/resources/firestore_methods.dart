import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  Future<List<String>> addUserToLobby(String username, String lobbyId,
      int numberOfRounds, String gameType, bool isCustom) async {
    int millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    String userId = millisecondsSinceEpoch.toString();

    CollectionReference usersInLobbyRef;

    if (isCustom) {
      usersInLobbyRef = _firestore.collection('usersInLobby_$lobbyId');
      if (await FirestoreMethods().checkIfDocExists(lobbyId)) {
        return ['alreadyExist'];
      }
    } else {
      usersInLobbyRef = _firestore.collection('usersInLobby');
    }

    await usersInLobbyRef.doc(userId).set({
      'username': username,
      'userId': userId,
      'inGame': 'not in game yet',
    });

    //counting users in lobby, and if there are 2 deleting them from lobby and adding to a list of users for a game
    AggregateQuerySnapshot query = await usersInLobbyRef.count().get();

    int numberOfUsersInLobby = query.count;

    if (numberOfUsersInLobby == 2) {
      var usersSnap = await usersInLobbyRef.get();
      List<String> usersId = [];
      List<String> usernames = [];
      for (var doc in usersSnap.docs) {
        String userId = doc['userId'];
        String username = doc['username'];
        usersId.add(userId);
        usernames.add(username);
        usersInLobbyRef.doc(userId).delete();
      }

      //Creating a list of random ids of questions for the game, depending on how many rounds users wants
      List<int> questionsIds = [];

      AggregateQuerySnapshot questionsQuery =
          await _firestore.collection(gameType).count().get();

      int numbersOfQuestions = questionsQuery.count;

      for (int i = 0; i < numberOfRounds; i += 1) {
        questionsIds.add(random(0, numbersOfQuestions));
      }
      if (isCustom) {
        createGame(usersId, lobbyId, usernames, questionsIds);
      } else {
        createGame(usersId, usersId[0] + usersId[1], usernames, questionsIds);
      }
    }

    return [userId, lobbyId];
  }

  Future<void> createGame(List<String> users, String gameId,
      List<String> usernames, List<int> questionsIds) async {
    await _firestore.collection('games').doc(gameId).set({
      'userId1': users[0],
      'username1': usernames[0],
      'points_${users[0]}': 0,
      'userId2': users[1],
      'username2': usernames[1],
      'points_${users[1]}': 0,
      'gameId': gameId,
      'gameStatus': 'start',
      'questionsIds': questionsIds,
      'round_${users[0]}': 0,
      'round_${users[1]}': 0,
    });
  }

  Future<Map<String, dynamic>> getGameSnapAsMap(String gameId) async {
    DocumentSnapshot gameSnap =
        await _firestore.collection('games').doc(gameId).get();

    return gameSnap.data() as Map<String, dynamic>;
  }

  Future<void> changeGameStatus(String gameId, String newStatus) async {
    await _firestore.collection('games').doc(gameId).update({
      'gameStatus': newStatus,
    });
  }

  Future<void> deleteGame(String gameId) async {
    await _firestore.collection('games').doc(gameId).delete();
  }

  Future<void> incrementUserRound(String gameId, String userId) async {
    await _firestore
        .collection('games')
        .doc(gameId)
        .update({'round_$userId': FieldValue.increment(1)});
  }

  Future<bool> checkIfDocExists(String docId) async {
    try {
      var gameDocRef =
          await _firestore.collection('collectionName').doc(docId).get();

      return gameDocRef.exists;
    } catch (e) {
      rethrow;
    }
  }
}
