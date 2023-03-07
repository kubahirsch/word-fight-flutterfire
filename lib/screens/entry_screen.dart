import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';

import 'lobby_searching_screen.dart';

class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController roundController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 300,
        ),
        const Text('Witam w grze w której możesz sprawdzić swoją erudycję'),
        TextField(
          controller: usernameController,
          decoration: const InputDecoration(hintText: 'podaj swój nick'),
        ),
        TextField(
          controller: roundController,
          decoration: const InputDecoration(hintText: 'Ile ma być rund'),
        ),
        InkWell(
          onTap: () async {
            setState(() {
              isLoading = true;
            });
            String userId = await FirestoreMethods().addUserToLobby(
                usernameController.text, int.parse(roundController.text));
            Provider.of<UserProvider>(context, listen: false).setUserId(userId);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const LobbySearching(),
            ));
          },
          child: isLoading
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                )
              : Container(
                  width: 200,
                  height: 60,
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: const Center(child: Text("GRAMY")),
                ),
        ),
      ]),
    );
  }
}
