import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/screens/choose_mode_screen.dart';
import 'package:wordfight/screens/home_screen.dart';
import 'package:wordfight/screens_for_single_player/question1_single_screen.dart';

import '../utils/colors.dart';

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
      appBar: AppBar(
        title: const Text('Koniec'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text('Za ten wyraz zdobyłeś $points punktów'),
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
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const Question1Single(),
                            ),
                          );
                        },
                        child: const Text('Następny wyraz'),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text('Koniec gry'),
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
