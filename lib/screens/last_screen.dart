import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens/choose_mode_screen.dart';

import '../resources/firestore_methods.dart';
import 'random_player_screen.dart';

class Last extends StatefulWidget {
  const Last({super.key});

  @override
  State<Last> createState() => _LastState();
}

class _LastState extends State<Last> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    userProvider.refreshGameDataInProvider(userProvider.gameSnap!['gameId']);

    int myPoints =
        userProvider.getGameSnap!['points_${userProvider.getUserId}'];
    int rivalPoints =
        userProvider.getGameSnap!['points_${userProvider.getRivalId}'];

    String myUsername = userProvider.getMyUsername;
    String rivalUsername = userProvider.getRivalUsername;

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
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const ChooseMode(),
                ));
              },
              child: const Text('Nowa gra'),
            )
          ],
        ),
      ),
    );
  }
}
