import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';
import 'package:wordfight/widgets/appbar.dart';
import 'package:wordfight/utils/utils.dart';

import '../providers/user_provider.dart';
import '../widgets/custom_elevated_button.dart';
import 'lobby_searching_screen.dart';

class RandomPlayerScreen extends StatefulWidget {
  const RandomPlayerScreen({super.key});

  @override
  State<RandomPlayerScreen> createState() => _RandomPlayerScreenState();
}

class _RandomPlayerScreenState extends State<RandomPlayerScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false).getUser;
    var gameProvider = Provider.of<GameProvider>(context, listen: false);

    String gameType = gameTypeToDisplay(context);

    return Scaffold(
      appBar: const CustomAppBar(),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Losowy przeciwnik',
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
              CustomElevatedButton(
                text: 'Szukaj przeciwnika',
                onPressed: () async {
                  setState(() {
                    isLoading = true;
                  });

                  var userId = await FirestoreMethods().addUserToLobby(
                      user!.username,
                      '',
                      3,
                      Provider.of<GameProvider>(context, listen: false)
                          .getGameType,
                      false);
                  gameProvider.setUserId(userId[0]);
                  gameProvider.setMyUsername(user.username);
                  if (mounted) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const LobbySearching(),
                    ));
                  }
                },
                isLoading: isLoading,
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
