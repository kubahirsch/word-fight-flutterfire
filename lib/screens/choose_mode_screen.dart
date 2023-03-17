import 'package:flutter/material.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens/random_player_screen.dart';
import 'package:wordfight/utils/colors.dart';

class ChooseMode extends StatelessWidget {
  const ChooseMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(height: 100),
          CustomButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const EntryScreen(),
              ));
            },
            text: 'Losowy przeciwnik',
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
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
