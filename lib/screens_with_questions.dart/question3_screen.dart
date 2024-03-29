import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/resources/question_methods.dart';
import 'package:wordfight/screens_with_questions.dart/question4_screen.dart';
import 'package:wordfight/utils/colors.dart';
import 'package:wordfight/widgets/custom_percent_indicator.dart';

import '../providers/question_provider.dart';
import '../widgets/result_container.dart';

class Question3 extends StatefulWidget {
  const Question3({super.key});

  @override
  State<Question3> createState() => _Question3State();
}

class _Question3State extends State<Question3> {
  List<String> visability = ['dontShow', 'dontShow', 'dontShow'];

  @override
  void initState() {
    // Timer(const Duration(seconds: 10), () {
    //   if (mounted) {
    //     Navigator.of(context).pushReplacement(MaterialPageRoute(
    //       builder: (context) => const Question4(),
    //     ));
    //   }
    // });
    super.initState();
  }

  void onSentenceTap(String userId, String gameId, int sentenceNum,
      int correctSentence) async {
    if (sentenceNum == correctSentence) {
      await QuestionMethods().addingPointsToDatabase(userId, gameId, 2);

      setState(() {
        visability[sentenceNum] = 'correct';
      });
    } else {
      setState(() {
        visability[sentenceNum] = 'incorrect';
      });

      await QuestionMethods().addingPointsToDatabase(userId, gameId, -2);
    }

    if (visability[0] != 'dontShow' &&
        visability[1] != 'dontShow' &&
        visability[2] != 'dontShow' &&
        mounted) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Question4(),
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 70),
            const Text(
              'Czy wyraz jest poprawnie użyty w zdaniu ?',
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
            ),
            // (visability[0] == 'dontShow')
            //     ? SentenceRow(
            //         sentenceNum: 0,
            //         sentence: questionData['sentence1'],
            //         onSentenceTap: onSentenceTap)
            //     : (visability[0] == 'correct')
            //         ? const Text('DOBRZE, +3')
            //         : const Text(
            //             'ŹLE, to nie jest poprawne użycie tego słowa :(, tracisz 3 punkty'),
            // const SizedBox(height: 20),
            // (visability[1] == 'dontShow')
            //     ? SentenceRow(
            //         sentenceNum: 1,
            //         sentence: questionData['sentence2'],
            //         onSentenceTap: onSentenceTap)
            //     : (visability[1] == 'correct')
            //         ? const Text('DOBRZE, +3')
            //         : const Text(
            //             'ŹLE, to nie jest poprawne użycie tego słowa :(, tracisz 3 punkty'),
            // const SizedBox(height: 20),
            // (visability[2] == 'dontShow')
            //     ? SentenceRow(
            //         sentenceNum: 2,
            //         sentence: questionData['sentence3'],
            //         onSentenceTap: onSentenceTap,
            //       )
            //     : (visability[2] == 'correct')
            //         ? const Text('DOBRZE, +3')
            //         : const Text(
            //             'ŹLE, to nie jest poprawne użycie tego słowa :(, tracisz 3 punkty'),
            // const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SentenceRow extends StatefulWidget {
  final String sentence;
  final Function(String, String, int, int) onSentenceTap;
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
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    String userId = gameProvider.getUserId;
    String gameId = gameProvider.getMyGame!;

    int correctSentence = Provider.of<QuestionProvider>(context, listen: false)
        .getQuestionDataAsMap['correctSentence'];

    return Column(
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
            child: Row(
              children: [
                Flexible(
                    child: Text(
                  widget.sentence,
                  style: const TextStyle(fontSize: 15),
                )),
                InkWell(
                  onTap: () => widget.onSentenceTap(
                      userId, gameId, widget.sentenceNum, correctSentence),
                  child: Container(
                    decoration: const BoxDecoration(
                        color: buttonHoverYellow,
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    width: 50,
                    height: double.infinity,
                    child: const Center(
                      child: Text(
                        'TAK',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
