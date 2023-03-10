import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens/last_screen.dart';
import 'package:wordfight/screens_with_questions.dart/question1_screen.dart';

class EndOfRound extends StatefulWidget {
  const EndOfRound({super.key});

  @override
  State<EndOfRound> createState() => _EndOfRoundState();
}

class _EndOfRoundState extends State<EndOfRound> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String gameId = userProvider.getMyGame;
    String userId = userProvider.getUserId;
    String rivalId = userProvider.getRivalId;
    Map<String, dynamic> questionData =
        Provider.of<QuestionProvider>(context).getQuestionDataAsMap;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }
        if (snapshot.hasError) {
          return const SnackBar(content: Text("Some error occured"));
        }
        Map<String, dynamic> gameData =
            snapshot.data!.data() as Map<String, dynamic>;
        if (gameData['round_$userId'] == userProvider.getQuestions.length &&
            userProvider.getQuestions.length == gameData['round_$rivalId']) {
          Timer(const Duration(seconds: 5), () async {
            // Refreshing game before going to end screen, so I know what is current status of the game
            await userProvider
                .refreshGameDataInProvider(userProvider.getMyGame);

            if (mounted) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Last(),
              ));
            }
          });

          return BothEnded(
              myPoints: gameData['points_$userId'],
              rivalPoints: gameData['points_$rivalId'],
              questionData: questionData);
        } else if (gameData['round_$userId'] == gameData['round_$rivalId']) {
          Timer(const Duration(seconds: 5), () async {
            // Refreshing game before going to end screen, so I know what is current status of the game
            await userProvider
                .refreshGameDataInProvider(userProvider.getMyGame);

            if (mounted) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Question1(),
              ));
            }
          });

          return BothEnded(
            myPoints: gameData['points_$userId'],
            rivalPoints: gameData['points_$rivalId'],
            questionData: questionData,
          );
        } else {
          return OneEnded(
            questionData: questionData,
            myPoints: gameData['points_$userId'],
            rivalPoints: gameData['points_$rivalId'],
          );
        }
      },
    );
  }
}

class BothEnded extends StatefulWidget {
  final int myPoints;
  final int rivalPoints;
  final Map<String, dynamic> questionData;
  const BothEnded(
      {super.key,
      required this.myPoints,
      required this.rivalPoints,
      required this.questionData});

  @override
  State<BothEnded> createState() => _BothEndedState();
}

class _BothEndedState extends State<BothEnded> {
  @override
  Widget build(BuildContext context) {
    String word = widget.questionData['word'];
    String meaning = widget.questionData["${widget.questionData['correct']}"];
    String synonyms = widget.questionData['synonyms'].toString();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 70),
          Text(
              'Twój przeciwnik ma ${widget.rivalPoints}, a ty ${widget.myPoints}'),
          const SizedBox(height: 70),
          Text(word),
          Text('To słowo oznacza: $meaning'),
          Text('Synonimy: $synonyms'),
        ],
      ),
    );
  }
}

class OneEnded extends StatefulWidget {
  final Map<String, dynamic> questionData;
  final int myPoints;
  final int rivalPoints;
  const OneEnded(
      {super.key,
      required this.questionData,
      required this.myPoints,
      required this.rivalPoints});

  @override
  State<OneEnded> createState() => _OneEndedState();
}

class _OneEndedState extends State<OneEnded> {
  @override
  Widget build(BuildContext context) {
    String word = widget.questionData['word'];
    String meaning = widget.questionData["${widget.questionData['correct']}"];
    String synonyms = widget.questionData['synonyms'].toString();

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 70),
          const Text('Poczekaj aż twój przeciwnik skończy rundę'),
          const SizedBox(height: 70),
          Text(
              'Twój przeciwnik ma ${widget.rivalPoints}, a ty ${widget.myPoints}'),
          const SizedBox(height: 70),
          Text(word),
          Text('To słowo oznacza: $meaning'),
          Text('Synonimy: $synonyms'),
        ],
      ),
    );
  }
}
