import 'package:flutter/material.dart';
import 'package:wordfight/screens/current_score_screen.dart';
import 'package:wordfight/screens/screens_with_questions.dart/question2_screen.dart';

import '../one_finished_screen.dart';

class Question1 extends StatefulWidget {
  const Question1({super.key});

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Czy znasz wyraz'),
            Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Question2(),
                      ));
                    },
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.amber),
                      width: 40,
                      height: 50,
                      child: const Text('tak'),
                    )),
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
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
  }
}
