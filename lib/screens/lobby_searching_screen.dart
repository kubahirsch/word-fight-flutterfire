import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens/found_player_screen.dart';
import 'package:wordfight/screens_with_questions.dart/question1_screen.dart';

class LobbySearching extends StatefulWidget {
  const LobbySearching({super.key});

  @override
  State<LobbySearching> createState() => _LobbySearchingState();
}

class _LobbySearchingState extends State<LobbySearching> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String userId = userProvider.getUserId;

    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('games').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          );
        }
        if (snapshot.hasError) {
          return const Text('Coś poszło nie tak');
        }
        String gameId = '0';

        // checking if the game was created with myid
        for (var doc in snapshot.data!.docs) {
          if (doc.data()['userId1'] == userId ||
              doc.data()['userId2'] == userId) {
            gameId = doc.data()['gameId'];
            break;
          }
        }

        if (gameId != '0') {
          userProvider.refreshGameDataInProvider(gameId);

          return const FoundPlayer();
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                children: const [
                  SizedBox(height: 100),
                  Text('Szukamy dla ciebie zawodnika!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                      )),
                  SizedBox(height: 100),
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      color: Colors.amber,
                    ),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
