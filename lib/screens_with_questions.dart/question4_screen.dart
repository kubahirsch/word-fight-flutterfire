import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';

import '../screens/one_finished_screen.dart';

class Question4 extends StatefulWidget {
  const Question4({super.key});

  @override
  State<Question4> createState() => _Question4State();
}

class _Question4State extends State<Question4> {
  final synonimController = TextEditingController();

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () async {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const End(),
      ));
    });
    super.initState();
  }

  @override
  void dispose() {
    synonimController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
          const Text(
              'W tej rundzie musisz podać jak najwięcej synonimów, jeżeli będą w naszej bazie danych, to za każdy synonim dostajesz 3 pkt'),
          TextField(
            controller: synonimController,
            decoration: const InputDecoration(hintText: 'Synonim'),
          ),
          const SizedBox(height: 60),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 20)),
            onPressed: () {
              synonimController.clear();
            },
            child: const Text('Sprawdź !'),
          ),
        ],
      ),
    );
  }
}
