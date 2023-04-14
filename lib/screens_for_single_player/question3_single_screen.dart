import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/screens_for_single_player/question4_single_screen.dart';

import '../utils/colors.dart';
import '../widgets/custom_percent_indicator.dart';

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Trzecie pytanie'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 100),
            const CustomPercentIndicator(animationDuration: 10000),
            const SizedBox(height: 30),
            const Text(
              'W tej rundzie musisz powiedzieć czy zdanie jest poprawnie użyte. ',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 50),
            (visability[0] == 'dontShow')
                ? SentenceRow(
                    sentenceNum: 0,
                    sentence: questionData['sentence1'],
                    onSentenceTap: onSentenceTap)
                : (visability[0] == 'correct')
                    ? const Text('DOBRZE, +3')
                    : const Text(
                        'ŹLE, to nie jest poprawne użycie tego słowa :(, tracisz 3 punkty'),
            const SizedBox(height: 20),
            (visability[1] == 'dontShow')
                ? SentenceRow(
                    sentenceNum: 1,
                    sentence: questionData['sentence2'],
                    onSentenceTap: onSentenceTap)
                : (visability[1] == 'correct')
                    ? const Text('DOBRZE, +3')
                    : const Text(
                        'ŹLE, to nie jest poprawne użycie tego słowa :(, tracisz 3 punkty'),
            const SizedBox(height: 20),
            (visability[2] == 'dontShow')
                ? SentenceRow(
                    sentenceNum: 2,
                    sentence: questionData['sentence3'],
                    onSentenceTap: onSentenceTap,
                  )
                : (visability[2] == 'correct')
                    ? const Text('DOBRZE, +3')
                    : const Text(
                        'ŹLE, to nie jest poprawne użycie tego słowa :(, tracisz 3 punkty'),
            const SizedBox(height: 20),
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
  @override
  Widget build(BuildContext context) {
    int correctSentence = Provider.of<QuestionProvider>(context, listen: false)
        .getQuestionDataAsMap['correctSentence'];

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: buttonYellow),
              borderRadius: const BorderRadius.all(Radius.circular(5))),
          height: 80,
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
                  onTap: () =>
                      widget.onSentenceTap(widget.sentenceNum, correctSentence),
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
