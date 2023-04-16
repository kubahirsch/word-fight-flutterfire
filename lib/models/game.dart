import 'package:flutter/material.dart';

class Game {
  final String myId;
  final String rivalId;
  final String gameId;
  final List<dynamic> questions;
  final String myUsername;
  final String rivalUsername;

  Game(
      {required this.myId,
      required this.rivalId,
      required this.gameId,
      required this.questions,
      required this.myUsername,
      required this.rivalUsername});
}
