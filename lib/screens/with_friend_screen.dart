import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/utils/utils.dart';
import 'package:wordfight/widgets/appbar.dart';

import '../providers/game_provider.dart';
import '../resources/firestore_methods.dart';
import '../widgets/custom_elevated_button.dart';
import 'lobby_searching_screen.dart';

class WithFriendScreen extends StatefulWidget {
  const WithFriendScreen({super.key});

  @override
  State<WithFriendScreen> createState() => _WithFriendScreenState();
}

class _WithFriendScreenState extends State<WithFriendScreen> {
  bool isLoading = false;
  TextEditingController lobbyIdController = TextEditingController();

  Future<void> joiningGame() async {
    var gameProvider = Provider.of<GameProvider>(context, listen: false);
    String username =
        Provider.of<UserProvider>(context, listen: false).getUser!.username;
    var userIdAndGameId = await FirestoreMethods().addUserToLobby(
      username,
      lobbyIdController.text,
      3,
      Provider.of<GameProvider>(context, listen: false).getGameType,
      true,
    );
    if (userIdAndGameId[0] == 'exists' && mounted) {
      showSnackBar('Lobby o takiej nazwie już istnieje i jest pełne', context);
    } else {
      gameProvider.setUserId(userIdAndGameId[0]);
      gameProvider.setMyUsername(username);
      gameProvider.setGameId(userIdAndGameId[1]);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const LobbySearching(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> textButtons = [
      TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          joiningGame();
        },
        child: const Text('Tak'),
      ),
      TextButton(
        style: TextButton.styleFrom(foregroundColor: Colors.black),
        onPressed: () {
          setState(() {
            isLoading = false;
          });
          Navigator.pop(context);
        },
        child: const Text('Nie'),
      ),
    ];

    String gameType = gameTypeToDisplay(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 120,
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Graj z przyjacielem',
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  ),
                  Text(
                    gameType,
                    style: const TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ],
              ),
            ),
            const Spacer(),
            TextFieldWithBorder(
              usernameController: lobbyIdController,
              hintText: 'Nazwa lobby...',
            ),
            const SizedBox(
              height: 30,
            ),
            CustomElevatedButton(
                text: 'Dołącz do tego lobby',
                onPressed: () async {
                  if (lobbyIdController.text.isEmpty) {
                    showSnackBar(
                        'Podaj nazwę lobby, do którego chcesz dołączyć, albo które chcesz stworzyć',
                        context);
                  } else {
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
                                  actions: textButtons,
                                ));
                      }
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      joiningGame();
                    }
                  }
                },
                isLoading: isLoading),
            const SizedBox(height: 30),
            CustomElevatedButton(
                text: 'Stwórz to lobby',
                onPressed: () async {
                  if (lobbyIdController.text.isEmpty) {
                    showSnackBar(
                        'Podaj nazwę lobby, do którego chcesz dołączyć, albo które chcesz stworzyć',
                        context);
                  } else {
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
                                  actions: textButtons,
                                ));
                      }
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      joiningGame();
                    }
                  }
                },
                isLoading: isLoading),
            const Spacer(),
          ],
        ),
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
      style: const TextStyle(
          color: Colors.black, fontFamily: 'Oswald', fontSize: 20),
      controller: usernameController,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.black, style: BorderStyle.solid)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black)),
        hintText: hintText,
      ),
    );
  }
}
