import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';
import 'package:wordfight/resources/question_methods.dart';
import 'package:wordfight/screens_with_questions.dart/question1_screen.dart';

import '../providers/game_provider.dart';
import '../screens/one_finished_screen.dart';

class Question4 extends StatefulWidget {
  const Question4({super.key});

  @override
  State<Question4> createState() => _Question4State();
}

class _Question4State extends State<Question4> {
  final synonymController = TextEditingController();
  List<String> addedSynonyms = [];

  @override
  void initState() {
    Timer(const Duration(seconds: 15), () async {
      //here I had to update provider because I didn't want userprovider to be listen true on the last page, and I needed latest gameStatus from db
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      await userProvider.refreshGameDataInProvider(userProvider.getMyGame);

      GameProvider gameProvider =
          Provider.of<GameProvider>(context, listen: false);

      if (gameProvider.getRoundNumber == userProvider.getQuestions.length) {
        // go to page with end of the game
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const End(),
        ));
      } else {
        //change round number and go to 1 question screen
        gameProvider.increaseRoundNumber();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Question1(),
        ));
      }
    });
    super.initState();
  }

  void checkSynonym(
      List<dynamic> synonyms, String inputSynonym, BuildContext context) {
    String userId = Provider.of<UserProvider>(context, listen: false).getUserId;
    String gameId = Provider.of<UserProvider>(context, listen: false).getMyGame;

    if (synonyms.contains(inputSynonym) &&
        !(addedSynonyms.contains(inputSynonym))) {
      QuestionMethods().addingPointsToDatabase(userId, gameId, 5);
      setState(() {
        addedSynonyms.add(inputSynonym);
      });
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            if (mounted) {
              Navigator.of(context).pop(true);
            }
          });
          return const AlertDialog(
            shape: CircleBorder(),
            title: Text('+5'),
            backgroundColor: Color.fromARGB(255, 47, 189, 52),
          );
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          if (mounted) {
            Future.delayed(const Duration(seconds: 1), () {
              Navigator.of(context).pop(true);
            });
          }
          return const AlertDialog(
            shape: CircleBorder(),
            title: Text('X'),
            backgroundColor: Colors.red,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    synonymController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> questionData =
        Provider.of<QuestionProvider>(context, listen: false)
            .getQuestionDataAsMap;

    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          LinearPercentIndicator(
            percent: 1,
            animation: true,
            animationDuration: 15000,
            lineHeight: 20,
            backgroundColor: Colors.grey,
            progressColor: Colors.amber,
          ),
          const Text(
              'W tej rundzie musisz podać jak najwięcej synonimów, jeżeli będą w naszej bazie danych, to za każdy synonim dostajesz 3 pkt'),
          TextField(
            controller: synonymController,
            decoration: const InputDecoration(
              hintText: 'Synonim',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 20)),
            onPressed: () {
              checkSynonym(questionData['synonyms'],
                  synonymController.text.toLowerCase(), context);
              synonymController.clear();
            },
            child: const Text('Sprawdź !'),
          ),
        ],
      ),
    );
  }
}
