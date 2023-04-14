// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String username;
  final String password;
  final String email;
  final String photoUrl;

  User({
    required this.username,
    required this.password,
    required this.email,
    required this.photoUrl,
  });

  static User userModelFromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
      username: snapshot['username'],
      password: snapshot['password'],
      email: snapshot['email'],
      photoUrl: snapshot['photoUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
        'photoUrl': photoUrl,
      };
}
