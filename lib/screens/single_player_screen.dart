import 'package:flutter/material.dart';
import 'package:wordfight/screens_for_single_player/question1_single_screen.dart';
import 'package:wordfight/utils/utils.dart';
import 'package:wordfight/widgets/appbar.dart';

import '../widgets/custom_elevated_button.dart';

class SinglePlayerScreen extends StatefulWidget {
  const SinglePlayerScreen({super.key});

  @override
  State<SinglePlayerScreen> createState() => _SinglePlayerScreenState();
}

class _SinglePlayerScreenState extends State<SinglePlayerScreen> {
  @override
  Widget build(BuildContext context) {
    String gameType = gameTypeToDisplay(context);
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rozgrywka samodzielna',
                      style: TextStyle(color: Colors.black, fontSize: 40),
                    ),
                    Text(
                      gameType,
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              const Spacer(),
              CustomElevatedButton(
                  text: 'Zaczynamy',
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const Question1Single(),
                      ),
                    );
                  },
                  isLoading: false),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
