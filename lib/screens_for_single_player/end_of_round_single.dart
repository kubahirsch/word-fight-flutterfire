import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/screens/choose_mode_screen.dart';
import 'package:wordfight/screens/home_screen.dart';
import 'package:wordfight/screens_for_single_player/question1_single_screen.dart';

import '../utils/colors.dart';
import '../widgets/custom_elevated_button.dart';

class EndOfRoundSingle extends StatefulWidget {
  const EndOfRoundSingle({super.key});

  @override
  State<EndOfRoundSingle> createState() => _EndOfRoundSingleState();
}

class _EndOfRoundSingleState extends State<EndOfRoundSingle> {
  @override
  Widget build(BuildContext context) {
    var questionData =
        Provider.of<QuestionProvider>(context).getQuestionDataAsMap;

    String word = questionData['word'];
    String meaning = questionData["${questionData['correct']}"];
    int points = Provider.of<QuestionProvider>(context).getPoints;
    List<dynamic> synonyms = questionData['synonyms'];

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Text(
              'Wynik: $points pkt.',
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Container(
                  width: double.infinity,
                  height: 500,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.black),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        word,
                        style: const TextStyle(
                            fontSize: 33, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        meaning,
                        style: const TextStyle(
                            fontStyle: FontStyle.italic, fontSize: 20),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Synonimy: ',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(synonyms.join(", ")),
                      SizedBox(height: 10),
                      const Spacer(),
                      CustomElevatedButton(
                        isLoading: false,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Question1Single(),
                            ),
                          );
                        },
                        text: 'Następny wyraz',
                      ),
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        isLoading: false,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: 'Koniec gry',
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
