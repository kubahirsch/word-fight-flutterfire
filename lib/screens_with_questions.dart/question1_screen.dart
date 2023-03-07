import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/screens/current_score_screen.dart';
import 'package:wordfight/screens_with_questions.dart/question2_screen.dart';

import '../screens/one_finished_screen.dart';

class Question1 extends StatefulWidget {
  const Question1({super.key});

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<QuestionProvider>(context, listen: false)
          .setQuestionDataInProvider(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic>? questionData =
              Provider.of<QuestionProvider>(context).getQuestionDataAsMap;
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
                        onTap: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const End(),
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
