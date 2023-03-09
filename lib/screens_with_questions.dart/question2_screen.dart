import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/resources/question_methods.dart';
import 'package:wordfight/screens_with_questions.dart/question3_screen.dart';

import '../providers/question_provider.dart';

class Question2 extends StatefulWidget {
  const Question2({super.key});

  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            LinearPercentIndicator(
              percent: 1,
              animation: true,
              animationDuration: 5000,
              lineHeight: 20,
              backgroundColor: Colors.grey,
              progressColor: Colors.amber,
            ),
            const Text('Co oznacza to słowo ?'),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      AnswerContainer(
                          answerText: questionData['a'], myAnswer: 'a'),
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
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String userId = userProvider.getUserId;
    String gameId = userProvider.getMyGame;

    String correct = Provider.of<QuestionProvider>(context, listen: false)
        .getQuestionDataAsMap['correct'];

    return InkWell(
      onTap: () => choosingAnswer(correct, myAnswer, userId, gameId, context),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(color: Colors.amber),
        width: 120,
        height: 50,
        child: Text(answerText),
      ),
    );
  }
}
