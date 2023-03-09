import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/resources/question_methods.dart';
import 'package:wordfight/screens_with_questions.dart/question4_screen.dart';

import '../providers/question_provider.dart';

class Question3 extends StatefulWidget {
  const Question3({super.key});

  @override
  State<Question3> createState() => _Question3State();
}

class _Question3State extends State<Question3> {
  List<String> visability = ['dontShow', 'dontShow', 'dontShow'];

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Question4(),
        ));
      }
    });
    super.initState();
  }

  void onSentenceTap(String userId, String gameId, int sentenceNum,
      int correctSentence, BuildContext context) async {
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
        visability[2] != 'dontShow') {
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
      body: Column(
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
          const Text(
              'W tej rundzie musisz powiedzieć czy zdanie jest poprawnie użyte. Za każdą poprawną odpowiedź dostajesz 2 pkt, a za zła -2'),
          const SizedBox(height: 50),
          (visability[0] == 'dontShow')
              ? SentenceRow(
                  sentenceNum: 0,
                  sentence: questionData['sentence1'],
                  onSentenceTap: onSentenceTap)
              : (visability[0] == 'correct')
                  ? const Text('DOBRZE')
                  : const Text('ŹLE :('),
          (visability[1] == 'dontShow')
              ? SentenceRow(
                  sentenceNum: 1,
                  sentence: questionData['sentence2'],
                  onSentenceTap: onSentenceTap)
              : (visability[1] == 'correct')
                  ? const Text('DOBRZE')
                  : const Text('ŹLE :('),
          (visability[2] == 'dontShow')
              ? SentenceRow(
                  sentenceNum: 2,
                  sentence: questionData['sentence3'],
                  onSentenceTap: onSentenceTap,
                )
              : (visability[2] == 'correct')
                  ? const Text('DOBRZE')
                  : const Text('ŹLE :('),
        ],
      ),
    );
  }
}

class SentenceRow extends StatefulWidget {
  final String sentence;
  final Function(String, String, int, int, BuildContext) onSentenceTap;
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
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String userId = userProvider.getUserId;
    String gameId = userProvider.getMyGame;

    int correctSentence = Provider.of<QuestionProvider>(context, listen: false)
        .getQuestionDataAsMap['correctSentence'];

    return Row(
      children: [
        Text(widget.sentence),
        InkWell(
          onTap: () => widget.onSentenceTap(
              userId, gameId, widget.sentenceNum, correctSentence, context),
          child: const SizedBox(
            width: 50,
            height: 20,
            child: Text('tak'),
          ),
        ),
      ],
    );
  }
}
