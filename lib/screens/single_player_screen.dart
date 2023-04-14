import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/screens_for_single_player/question1_single_screen.dart';

import '../providers/game_provider.dart';

class SinglePlayerScreen extends StatefulWidget {
  const SinglePlayerScreen({super.key});

  @override
  State<SinglePlayerScreen> createState() => _SinglePlayerScreenState();
}

class _SinglePlayerScreenState extends State<SinglePlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gra samemu'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Text(
              'Witaj w trybie dla jednej osoby ! Za złe odpowiedzi dostaje się minusowe punkty, postaraj się zdobyć jak najwięcej'),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Question1Single(),
                  ),
                );
              },
              child: const Text('Zaczynamy'))
        ],
      ),
    );
  }
}
