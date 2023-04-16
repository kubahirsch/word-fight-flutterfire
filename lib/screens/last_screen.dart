import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/screens/choose_mode_screen.dart';
import 'package:wordfight/screens/home_screen.dart';

import '../resources/firestore_methods.dart';
import 'random_player_screen.dart';

class Last extends StatelessWidget {
  const Last({super.key});

  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    gameProvider.refreshGameDataInProvider(gameProvider.gameSnap!['gameId']);

    int myPoints =
        gameProvider.getGameSnap!['points_${gameProvider.getUserId}'];
    int rivalPoints =
        gameProvider.getGameSnap!['points_${gameProvider.getRivalId}'];

    String myUsername = gameProvider.getMyUsername;
    String rivalUsername = gameProvider.getRivalUsername;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Koniec gry'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            (myPoints > rivalPoints)
                ? const Text('Wygrywasz!!! ')
                : (myPoints < rivalPoints)
                    ? const Text('Wygrywa Twój przeciwnik... :( ')
                    : const Text('REMIS !'),
            const SizedBox(height: 50),
            Text('$myUsername: $myPoints'),
            const SizedBox(height: 20),
            const Text('vs'),
            const SizedBox(height: 20),
            Text('$rivalUsername: $rivalPoints'),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));

                var gameRef = await FirebaseFirestore.instance
                    .collection('games')
                    .doc(gameProvider.getMyGame)
                    .get();
                if (gameRef.exists) {
                  FirestoreMethods().deleteGame(gameProvider.getMyGame);
                }
              },
              child: const Text('Nowa gra'),
            )
          ],
        ),
      ),
    );
  }
}
