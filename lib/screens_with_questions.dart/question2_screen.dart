import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/screens_with_questions.dart/question3_screen.dart';

import '../providers/question_provider.dart';

class Question2 extends StatefulWidget {
  const Question2({super.key});

  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Question3(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic>? questionData =
        Provider.of<QuestionProvider>(context).getQuestionDataAsMap;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
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
            const Text('Co oznacza to słowo ?'),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.amber),
                          width: 120,
                          height: 50,
                          child: Text('${questionData['a']}'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.amber),
                          width: 120,
                          height: 50,
                          child: Text('${questionData['b']}'),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.amber),
                          width: 120,
                          height: 50,
                          child: Text('${questionData['c']}'),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(color: Colors.amber),
                          width: 120,
                          height: 50,
                          child: Text('${questionData['d']}'),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            //Zamiast tego guzika w przyszłości będzie timer
            InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const Question3(),
                  ));
                },
                child: const Text('Przejdź do następnego pytania')),
          ],
        ),
      ),
    );
  }
}
