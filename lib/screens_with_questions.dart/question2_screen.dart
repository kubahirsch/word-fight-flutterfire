import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wordfight/screens_with_questions.dart/question3_screen.dart';

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
                Row(
                  children: [
                    InkWell(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.amber),
                        width: 50,
                        height: 50,
                        child: const Text('1 odpowiedz'),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.amber),
                        width: 50,
                        height: 50,
                        child: const Text('2 odpowiedz'),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    InkWell(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.amber),
                        width: 50,
                        height: 50,
                        child: const Text('3 odpowiedz'),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.amber),
                        width: 50,
                        height: 50,
                        child: const Text('4 odpowiedz'),
                      ),
                    )
                  ],
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
