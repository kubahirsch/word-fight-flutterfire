import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';
import 'package:wordfight/screens/end_of_round_screen.dart';
import 'package:wordfight/screens_with_questions.dart/question2_screen.dart';
import 'package:wordfight/utils/colors.dart';

class Question1 extends StatefulWidget {
  const Question1({super.key});

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);

    return FutureBuilder(
      future: Provider.of<QuestionProvider>(context, listen: false)
          .setQuestionDataInProvider(gameProvider.gameSnap!['questionsIds']
              [(gameProvider.getRoundNumber) - 1]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? questionData =
              Provider.of<QuestionProvider>(context, listen: false)
                  .getQuestionDataAsMap;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: const Text('Pierwsze pytanie'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    const Text(
                      'Czy znasz wyraz:',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    Text(
                      questionData['word'],
                      style: const TextStyle(fontSize: 30),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      text: 'TAK',
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Question2(),
                        ));
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomButton(
                      text: 'NIE',
                      onPressed: () async {
                        await gameProvider
                            .refreshGameDataInProvider(gameProvider.getMyGame);
                        await FirestoreMethods().incrementUserRound(
                            gameProvider.getMyGame, gameProvider.getUserId);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const EndOfRound(),
                        ));
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }
      },
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(100))),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
