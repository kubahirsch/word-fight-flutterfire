import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/game_provider.dart';
import '../resources/firestore_methods.dart';
import '../utils/colors.dart';
import 'lobby_searching_screen.dart';

class WithFriendScreen extends StatefulWidget {
  const WithFriendScreen({super.key});

  @override
  State<WithFriendScreen> createState() => _WithFriendScreenState();
}

class _WithFriendScreenState extends State<WithFriendScreen> {
  bool isLoading = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController lobbyIdController = TextEditingController();

  Future<void> joiningGame() async {
    var gameProvider = Provider.of<GameProvider>(context, listen: false);
    var userIdAndGameId = await FirestoreMethods().addUserToCustomLobby(
        usernameController.text, lobbyIdController.text, 3);
    gameProvider.setUserId(userIdAndGameId[0]);
    gameProvider.setMyUsername(usernameController.text);
    gameProvider.setGameId(userIdAndGameId[1]);
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const LobbySearching(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gra z znajomym'),
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
          TextFieldWithBorder(
            usernameController: usernameController,
            hintText: 'Podaj swój nick',
          ),
          TextFieldWithBorder(
            usernameController: lobbyIdController,
            hintText:
                'Podaj id lobby do którego chcesz dołączyć, lub które chcesz stworzyć',
          ),
          const SizedBox(
            height: 100,
          ),
          ElevatedButton(
            onPressed: () async {
              bool lobbyExist = true;
              final snapshot = await FirebaseFirestore.instance
                  .collection('usersInLobby_${lobbyIdController.text}')
                  .get();
              if (snapshot.size == 0) {
                lobbyExist = false;
              }

              if (!lobbyExist) {
                if (mounted) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                'Lobby o takiej nazwie nie istnieje. '),
                            content: const Text(
                                'Czy chcesz stworzyć nowe lobby o takiej nazwie i czekać aż ktoś dołączy? '),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    joiningGame();
                                  },
                                  child: const Text('Tak')),
                              TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Nie')),
                            ],
                          ));
                }
              } else {
                setState(() {
                  isLoading = true;
                });
                joiningGame();
              }
            },
            child: isLoading
                ? const LoadingSizedBox()
                : Container(
                    width: 300,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: buttonYellow,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Center(child: Text("Dołącz do lobby")),
                  ),
          ),
          ElevatedButton(
            onPressed: () async {
              bool lobbyExist = true;
              final snapshot = await FirebaseFirestore.instance
                  .collection('usersInLobby_${lobbyIdController.text}')
                  .get();
              if (snapshot.size == 0) {
                lobbyExist = false;
              }

              if (lobbyExist) {
                if (mounted) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                                'Lobby o takiej nazwie już istnieje. '),
                            content: const Text(
                                'Czy chcesz dołączyć do tego lobby ?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    joiningGame();
                                  },
                                  child: const Text('Tak')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Nie')),
                            ],
                          ));
                }
              } else {
                setState(() {
                  isLoading = true;
                });
                joiningGame();
              }
            },
            child: isLoading
                ? const LoadingSizedBox()
                : Container(
                    width: 300,
                    height: 60,
                    decoration: const BoxDecoration(
                        color: buttonYellow,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: const Center(child: Text("Stwórz lobby")),
                  ),
          ),
        ]),
      ),
    );
  }
}

class LoadingSizedBox extends StatelessWidget {
  const LoadingSizedBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 60,
      child: Center(
        child: CircularProgressIndicator(color: Colors.amber),
      ),
    );
  }
}

class TextFieldWithBorder extends StatelessWidget {
  const TextFieldWithBorder({
    super.key,
    required this.usernameController,
    required this.hintText,
  });

  final TextEditingController usernameController;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: usernameController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: buttonYellow)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: buttonHoverYellow)),
        hintText: hintText,
      ),
    );
  }
}
