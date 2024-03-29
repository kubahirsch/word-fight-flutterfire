import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens/last_screen.dart';
import 'package:wordfight/screens/rival_left_screen.dart';
import 'package:wordfight/screens_with_questions.dart/question1_screen.dart';
import 'package:wordfight/utils/colors.dart';
import 'package:wordfight/utils/utils.dart';

class EndOfRound extends StatefulWidget {
  const EndOfRound({super.key});

  @override
  State<EndOfRound> createState() => _EndOfRoundState();
}

class _EndOfRoundState extends State<EndOfRound> {
  @override
  void initState() {
    super.initState();
    Provider.of<GameProvider>(context, listen: false).refreshGameDataInProvider(
        Provider.of<GameProvider>(context, listen: false).getMyGame!);
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);

    String? gameId = gameProvider.getMyGame;
    String userId = gameProvider.getUserId;
    String rivalId = gameProvider.getRivalId;

    Map<String, dynamic> questionData =
        Provider.of<QuestionProvider>(context).getQuestionDataAsMap;

    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(gameId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const RivalLeftScreen();
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }
        if (snapshot.hasError) {
          return const SnackBar(content: Text("Some error occured"));
        }
        Map<String, dynamic> gameData =
            snapshot.data!.data() as Map<String, dynamic>;

        if (gameData['round_$userId'] == gameProvider.getQuestions.length &&
            gameProvider.getQuestions.length == gameData['round_$rivalId']) {
          Timer(const Duration(seconds: 5), () async {
            // Refreshing game before going to end screen, so opponent knows what is current status of the game
            await gameProvider
                .refreshGameDataInProvider(gameProvider.getMyGame!);

            if (mounted) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Last(),
              ));
            }
          });

          return BothEnded(
              myUsername: gameProvider.getMyUsername,
              rivalUsername: gameProvider.getRivalUsername,
              round: gameData['round_$userId'],
              myPoints: gameData['points_$userId'],
              rivalPoints: gameData['points_$rivalId'],
              questionData: questionData);
        } else if (gameData['round_$userId'] == gameData['round_$rivalId']) {
          Timer(const Duration(seconds: 5), () async {
            // Refreshing game before going to end screen, so opponent knows what is current status of the game
            await gameProvider
                .refreshGameDataInProvider(gameProvider.getMyGame!);

            if (mounted) {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Question1(),
              ));
            }
          });

          return BothEnded(
            myUsername: gameProvider.getMyUsername,
            rivalUsername: gameProvider.getRivalUsername,
            round: gameData['round_$userId'],
            myPoints: gameData['points_$userId'],
            rivalPoints: gameData['points_$rivalId'],
            questionData: questionData,
          );
        } else {
          return OneEnded(
            myUsername: gameProvider.getMyUsername,
            rivalUsername: gameProvider.getRivalUsername,
            round: gameData['round_$userId'],
            questionData: questionData,
            myPoints: gameData['points_$userId'],
            rivalPoints: gameData['points_$rivalId'],
          );
        }
      },
    );
  }
}

class BothEnded extends StatelessWidget {
  final int myPoints;
  final int rivalPoints;
  final Map<String, dynamic> questionData;
  final String myUsername;
  final String rivalUsername;
  final int round;
  const BothEnded(
      {super.key,
      required this.myPoints,
      required this.rivalPoints,
      required this.questionData,
      required this.round,
      required this.myUsername,
      required this.rivalUsername});

  @override
  Widget build(BuildContext context) {
    String word = questionData['word'];
    String meaning = questionData["${questionData['correct']}"];
    List<dynamic> synonyms = questionData['synonyms'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Koniec $round/3 rundy'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 70),
            Text('$myUsername: $myPoints',
                style: const TextStyle(fontSize: 50)),
            const SizedBox(height: 10),
            const Text('vs', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            Text('$rivalUsername: $rivalPoints',
                style: const TextStyle(fontSize: 50)),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: buttonYellow),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        meaning,
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Synonimy: ',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(synonyms.join(", ")),
                      const SizedBox(height: 10),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class OneEnded extends StatelessWidget {
  final Map<String, dynamic> questionData;
  final int myPoints;
  final int rivalPoints;
  final int round;
  final String myUsername;
  final String rivalUsername;
  const OneEnded(
      {super.key,
      required this.questionData,
      required this.myPoints,
      required this.rivalPoints,
      required this.round,
      required this.myUsername,
      required this.rivalUsername});

  @override
  Widget build(BuildContext context) {
    String word = questionData['word'];
    String meaning = questionData["${questionData['correct']}"];
    List<dynamic> synonyms = questionData['synonyms'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Koniec $round/3 rundy'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text('Poczekaj aż twój przeciwnik skończy rundę'),
            const SizedBox(height: 70),
            Text('$myUsername: $myPoints',
                style: const TextStyle(fontSize: 50)),
            const SizedBox(height: 10),
            const Text('vs', style: TextStyle(fontSize: 30)),
            const SizedBox(height: 10),
            Text('$rivalUsername: $rivalPoints',
                style: const TextStyle(fontSize: 50)),
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: buttonYellow),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      word,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      meaning,
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Synonimy: ',
                      style: TextStyle(fontSize: 15),
                    ),
                    Text(synonyms.join(", ")),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
