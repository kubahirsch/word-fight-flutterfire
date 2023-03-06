import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> addUserToLobby(String username) async {
    int millisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    String userId = millisecondsSinceEpoch.toString();
    await _firestore.collection('usersInLobby').doc(userId).set({
      'username': username,
      'userId': userId,
      'inGame': 'not in game yet',
    });

    AggregateQuerySnapshot query =
        await _firestore.collection('usersInLobby').count().get();

    int numberOfUsersInLobby = query.count;

    if (numberOfUsersInLobby == 2) {
      var ref = await _firestore.collection('usersInLobby');
      var usersSnap = await ref.get();

      List<String> usersId = [];
      List<String> usernames = [];
      for (var doc in usersSnap.docs) {
        String userId = doc.data()['userId'];
        String username = doc.data()['username'];
        usersId.add(userId);
        usernames.add(username);
        ref.doc(userId).delete();
      }

      createGame(usersId, usersId[0] + usersId[1], usernames);
    }
    return userId;
  }

  Future<void> createGame(
      List<String> users, String gameId, List<String> usernames) async {
    await _firestore.collection('games').doc(gameId).set({
      'userId1': users[0],
      'username1': usernames[0],
      'points_${users[0]}': 0,
      'userId2': users[1],
      'username2': usernames[1],
      'points_${users[1]}': 0,
      'gameId': gameId,
      'gameStatus': 'start',
    });
  }

  Future<void> addingPoints(String userId, String gameId) async {
    await _firestore.collection('games').doc(gameId).update({
      'points_$userId': FieldValue.increment(1),
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
}
