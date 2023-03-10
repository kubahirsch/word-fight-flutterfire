import 'package:flutter/material.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens/random_player_screen.dart';

class ChooseMode extends StatelessWidget {
  const ChooseMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 70),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const EntryScreen(),
            ));
          },
          child: const Text('Losowy przeciwnik'),
        ),
        const SizedBox(
          height: 80,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Graj z przyjacielem'),
        ),
        const SizedBox(
          height: 80,
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Graj sam'),
        ),
      ]),
    );
  }
}
