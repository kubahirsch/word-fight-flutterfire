import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';

import '../resources/firestore_methods.dart';
import 'entry_screen.dart';

class Last extends StatefulWidget {
  const Last({super.key});

  @override
  State<Last> createState() => _LastState();
}

class _LastState extends State<Last> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    userProvider.refreshGameDataInProvider(userProvider.gameSnap!['gameId']);

    int myPoints =
        userProvider.getGameSnap!['points_${userProvider.getUserId}'];
    int rivalPoints =
        userProvider.getGameSnap!['points_${userProvider.getRivalId}'];

    return Column(
      children: [
        Text('Koniec gry dostałeś $myPoints, a twój rywal $rivalPoints'),
        const Text('Wygrywa '),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const EntryScreen(),
            ));
          },
          child: const Text('Nowa gra'),
        )
      ],
    );
  }
}
