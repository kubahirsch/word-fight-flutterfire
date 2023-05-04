import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/resources/question_methods.dart';
import 'package:wordfight/screens_with_questions.dart/question3_screen.dart';
import 'package:wordfight/utils/colors.dart';
import 'package:wordfight/widgets/custom_percent_indicator.dart';

import '../providers/question_provider.dart';

class Question2 extends StatefulWidget {
  const Question2({super.key});

  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Question3(),
        ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? questionData =
        Provider.of<QuestionProvider>(context, listen: false)
            .getQuestionDataAsMap;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text(
              '${questionData["word"]}'.toUpperCase(),
              style: const TextStyle(fontSize: 30, fontFamily: 'Playfair'),
            ),
            const SizedBox(height: 60),
            const CustomPercentIndicator(animationDuration: 10000),
            const SizedBox(height: 60),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      AnswerContainer(
                          answerText: questionData['a'], myAnswer: 'a'),
                      const SizedBox(
                        width: 20,
                      ),
                      AnswerContainer(
                          answerText: questionData['b'], myAnswer: 'b'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      AnswerContainer(
                          answerText: questionData['c'], myAnswer: 'c'),
                      const SizedBox(
                        width: 20,
                      ),
                      AnswerContainer(
                          answerText: questionData['d'], myAnswer: 'd'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AnswerContainer extends StatelessWidget {
  final String answerText;
  final String myAnswer;

  const AnswerContainer(
      {super.key, required this.answerText, required this.myAnswer});

  void choosingAnswer(String correct, String myAnswer, String userId,
      String gameId, BuildContext context) async {
    if (myAnswer == correct) {
      await QuestionMethods().addingPointsToDatabase(userId, gameId, 4);
    } else {
      await QuestionMethods().addingPointsToDatabase(userId, gameId, -4);
    }

    if (context.mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Question3(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    String userId = gameProvider.getUserId;
    String gameId = gameProvider.getMyGame!;

    String correct = Provider.of<QuestionProvider>(context, listen: false)
        .getQuestionDataAsMap['correct'];

    return Flexible(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    spreadRadius: 5)
              ]),
          width: double.infinity / 2,
          height: 200,
          child: Center(
              child: Text(
            answerText,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          )),
        ),
        onTap: () => choosingAnswer(correct, myAnswer, userId, gameId, context),
      ),
    );
  }
}
