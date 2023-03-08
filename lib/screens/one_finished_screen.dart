import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';
import 'package:wordfight/screens/entry_screen.dart';
import 'package:wordfight/screens/last_screen.dart';

class End extends StatefulWidget {
  const End({super.key});

  @override
  State<End> createState() => _EndState();
}

class _EndState extends State<End> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    //Changing game status in db depending on the players finished
    if (userProvider.gameSnap!['gameStatus'] == 'start') {
      FirestoreMethods()
          .changeGameStatus(userProvider.getMyGame, 'one-finished');
    } else if (userProvider.gameSnap!['gameStatus'] == 'one-finished') {
      FirestoreMethods().changeGameStatus(userProvider.getMyGame, 'end');
    }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('games')
          .doc(userProvider.myGame)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }
        if (snapshot.hasError) {
          return const Text('Coś poszło nie tak');
        }

        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          if (data['gameStatus'] == 'end') {
            return const Last();
          }
        }

        return Column(
          children: const [
            Text('Twój przewiwnik jeszcze gra, poczekaj aż skończy'),
            CircularProgressIndicator(
              color: Colors.amber,
            ),
          ],
        );
      },
    );
  }
}
