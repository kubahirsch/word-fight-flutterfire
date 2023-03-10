import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';
import 'package:wordfight/screens/end_of_round_screen.dart';
import 'package:wordfight/screens_with_questions.dart/question2_screen.dart';

class Question1 extends StatefulWidget {
  const Question1({super.key});

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);

    return FutureBuilder(
      future: Provider.of<QuestionProvider>(context, listen: false)
          .setQuestionDataInProvider(userProvider.gameSnap!['questionsIds']
              [(gameProvider.getRoundNumber) - 1]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? questionData =
              Provider.of<QuestionProvider>(context, listen: false)
                  .getQuestionDataAsMap;
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Text('Czy znasz wyraz'),
                  const SizedBox(height: 40),
                  Text(
                    questionData['word'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const Question2(),
                            ));
                          },
                          child: Container(
                            decoration:
                                const BoxDecoration(color: Colors.amber),
                            width: 40,
                            height: 50,
                            child: const Text('tak'),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          await userProvider.refreshGameDataInProvider(
                              userProvider.getMyGame);
                          await FirestoreMethods().incrementUserRound(
                              userProvider.getMyGame, userProvider.getUserId);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const EndOfRound(),
                          ));
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.amber),
                          width: 40,
                          height: 50,
                          child: const Text('nie'),
                        ),
                      )
                    ],
                  )
                ],
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
