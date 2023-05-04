import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/screens_for_single_player/question3_single_screen.dart';

import '../providers/question_provider.dart';
import '../widgets/custom_percent_indicator.dart';

class Question2Single extends StatefulWidget {
  const Question2Single({super.key});

  @override
  State<Question2Single> createState() => _Question2SingleState();
}

class _Question2SingleState extends State<Question2Single> {
  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Question3Single(),
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

  @override
  Widget build(BuildContext context) {
    String correct = Provider.of<QuestionProvider>(context, listen: false)
        .getQuestionDataAsMap['correct'];

    return Flexible(
      child: InkWell(
        onTap: () {
          if (myAnswer == correct) {
            Provider.of<QuestionProvider>(context, listen: false)
                .changePoints(4);
          } else {
            Provider.of<QuestionProvider>(context, listen: false)
                .changePoints(-4);
          }
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => const Question3Single(),
          ));
        },
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
      ),
    );
  }
}
