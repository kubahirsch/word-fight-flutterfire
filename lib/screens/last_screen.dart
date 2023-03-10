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

    return Column(
      children: [
        (myPoints > rivalPoints)
            ? const Text('Wygrywasz!!! ')
            : (myPoints < rivalPoints)
                ? const Text('Wygrywa Twój przeciwnik... :( ')
                : const Text('REMIS !'),
        const SizedBox(height: 50),
        Text('Dostałeś $myPoints, a twój rywal $rivalPoints'),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const ChooseMode(),
            ));
          },
          child: const Text('Nowa gra'),
        )
      ],
    );
  }
}
