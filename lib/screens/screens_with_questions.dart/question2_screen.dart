import 'package:flutter/material.dart';
import 'package:wordfight/screens/one_finished_screen.dart';

class Question2 extends StatefulWidget {
  const Question2({super.key});

  @override
  State<Question2> createState() => _Question2State();
}

class _Question2State extends State<Question2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const End(),
              ));
            },
            child: const Text('Przejdź do następnego pytania')),
      ),
    );
  }
}
