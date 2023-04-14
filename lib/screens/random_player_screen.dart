import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';

import '../utils/colors.dart';
import 'lobby_searching_screen.dart';

class RandomPlayerScreen extends StatefulWidget {
  const RandomPlayerScreen({super.key});

  @override
  State<RandomPlayerScreen> createState() => _RandomPlayerScreenState();
}

class _RandomPlayerScreenState extends State<RandomPlayerScreen> {
  TextEditingController usernameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gra z losowym przeciwnikiem'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          const SizedBox(
            height: 120,
          ),
          const Text(
            'Gra trwa 3 rundy. Można dostać minusowe i dodatnie punkty',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 30),
          TextField(
            style: const TextStyle(color: Colors.white),
            controller: usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonYellow)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: buttonHoverYellow)),
              hintText: 'podaj swój nick',
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });
              var gameProvider =
                  Provider.of<GameProvider>(context, listen: false);
              String userId = await FirestoreMethods()
                  .addUserToLobby(usernameController.text, 3);
              gameProvider.setUserId(userId);
              gameProvider.setMyUsername(usernameController.text);

              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LobbySearching(),
              ));
            },
            child: isLoading
                ? const SizedBox(
                    width: 300,
                    height: 60,
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.amber),
                    ),
                  )
                : Container(
                    width: 300,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: buttonYellow,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Center(child: Text("Szukaj zawodnika")),
                  ),
          ),
        ]),
      ),
    );
  }
}
