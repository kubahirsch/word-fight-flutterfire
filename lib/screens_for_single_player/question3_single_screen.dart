import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/screens_for_single_player/question4_single_screen.dart';

import '../screens_with_questions.dart/question3_screen.dart';
import '../utils/colors.dart';
import '../widgets/custom_percent_indicator.dart';
import '../widgets/result_container.dart';

class Question3Single extends StatefulWidget {
  const Question3Single({super.key});

  @override
  State<Question3Single> createState() => _Question3SingleState();
}

class _Question3SingleState extends State<Question3Single> {
  List<String> visability = ['dontShow', 'dontShow', 'dontShow'];

  @override
  void initState() {
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Question4Single(),
        ));
      }
    });
    super.initState();
  }

  void onSentenceTap(int sentenceNum, int correctSentence) async {
    var questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    if (sentenceNum == correctSentence) {
      questionProvider.changePoints(2);

      setState(() {
        visability[sentenceNum] = 'correct';
      });
    } else {
      setState(() {
        visability[sentenceNum] = 'incorrect';
      });

      questionProvider.changePoints(-2);
    }

    if (visability[0] != 'dontShow' &&
        visability[1] != 'dontShow' &&
        visability[2] != 'dontShow' &&
        mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Question4Single(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> questionData =
        Provider.of<QuestionProvider>(context, listen: false)
            .getQuestionDataAsMap;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Text(
              'Czy zdanie jest poprawnie użyte ?',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 23),
            ),
            const SizedBox(height: 30),
            const CustomPercentIndicator(animationDuration: 10000),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.6,
              width: double.infinity,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 30);
                },
                itemCount: 3,
                itemBuilder: (context, index) {
                  if (visability[index] == 'dontShow') {
                    return SentenceRow(
                        sentenceNum: index,
                        sentence: questionData['sentence${index + 1}'],
                        onSentenceTap: onSentenceTap);
                  } else {
                    if (visability[index] == 'correct') {
                      return ResultContainer(
                          sentence: questionData['sentence${index + 1}'],
                          isCorrect: true);
                    } else {
                      return ResultContainer(
                        sentence: questionData['sentence${index + 1}'],
                        isCorrect: false,
                      );
                    }
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SentenceRow extends StatefulWidget {
  final String sentence;
  final Function(int, int) onSentenceTap;
  final int sentenceNum;

  const SentenceRow(
      {super.key,
      required this.sentence,
      required this.onSentenceTap,
      required this.sentenceNum});

  @override
  State<SentenceRow> createState() => SentenceRowState();
}

class SentenceRowState extends State<SentenceRow> {
  bool isHolding = false;
  @override
  Widget build(BuildContext context) {
    int correctSentence = Provider.of<QuestionProvider>(context, listen: false)
        .getQuestionDataAsMap['correctSentence'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 5,
                  spreadRadius: 5,
                ),
              ],
            ),
            width: double.infinity,
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    widget.sentence,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onHighlightChanged: (value) {
                          if (value) {
                            setState(() {
                              isHolding = true;
                            });
                          } else {
                            setState(() {
                              isHolding = false;
                            });
                          }
                        },
                        onTap: () => widget.onSentenceTap(
                            widget.sentenceNum, correctSentence),
                        child: Container(
                          decoration: BoxDecoration(
                              color: isHolding ? Colors.black : Colors.white,
                              border: Border.all(color: Colors.black),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          width: 80,
                          height: 30,
                          child: Center(
                            child: Text(
                              'TAK',
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      isHolding ? Colors.white : Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
