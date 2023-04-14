import 'package:flutter/material.dart';
import 'package:wordfight/resources/auth_methods.dart';
import 'package:wordfight/screens/decision_tree.dart';
import 'package:wordfight/screens/random_player_screen.dart';
import 'package:wordfight/screens/single_player_screen.dart';
import 'package:wordfight/screens/with_friend_screen.dart';
import 'package:wordfight/utils/utils.dart';

class ChooseMode extends StatefulWidget {
  final String gameType;
  const ChooseMode({super.key, required this.gameType});

  @override
  State<ChooseMode> createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ChooseMode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.gameType),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100),
            CustomButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const RandomPlayerScreen(),
                ));
              },
              text: 'Losowy przeciwnik',
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const WithFriendScreen(),
                ));
              },
              child: const Text('Graj z przyjacielem'),
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SinglePlayerScreen(),
                  ),
                );
              },
              child: const Text('Graj sam'),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
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
