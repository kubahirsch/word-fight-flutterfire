import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/screens_for_single_player/question2_single_screen.dart';

import '../providers/question_provider.dart';
import 'end_of_round_single.dart';

class Question1Single extends StatefulWidget {
  const Question1Single({super.key});

  @override
  State<Question1Single> createState() => _Question1SingleState();
}

class _Question1SingleState extends State<Question1Single> {
  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  late String gameType;
  int? numOfQuestionsAvaible;

  @override
  void initState() {
    setVariables();
    super.initState();
  }

  void setVariables() async {
    gameType = Provider.of<GameProvider>(context, listen: false).getGameType;
    var querySnap =
        await FirebaseFirestore.instance.collection(gameType).count().get();
    setState(() {
      numOfQuestionsAvaible = querySnap.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (numOfQuestionsAvaible == null)
        ? const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          )
        : FutureBuilder(
            future: Provider.of<QuestionProvider>(context, listen: false)
                .setQuestionDataInProvider(
                    random(0, numOfQuestionsAvaible!), gameType),
            builder: (BuildContext context, var snapshot) {
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
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
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
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const Question2Single(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          CustomButton(
                            text: 'NIE',
                            onPressed: () async {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const EndOfRoundSingle(),
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
            });
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
