import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/models/user.dart' as model;
import 'package:wordfight/screens/choose_mode_screen_new.dart';

import '../providers/game_provider.dart';
import '../widgets/appbar.dart';
import 'admin_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  model.User? user;

  List<Widget> containers = [
    const Text(
      'Wybierz grę',
      style:
          TextStyle(color: Colors.black, fontSize: 40, fontFamily: 'Playfair'),
    ),
    const ListTab(
        gameType: 'questionsPolishEasy',
        backgroundUrl: Colors.amber,
        gameTypeToDisplay: 'Proste polskie'),
    const ListTab(
        gameType: 'questions',
        backgroundUrl: Colors.amber,
        gameTypeToDisplay: 'Trudne polskie'),
    const ListTab(
        gameType: 'questionsEnglishA1',
        backgroundUrl: Colors.amber,
        gameTypeToDisplay: 'Angielskie A1'),
    const ListTab(
        gameType: 'questionsEnglishA2',
        backgroundUrl: Colors.amber,
        gameTypeToDisplay: 'Angielskie A2'),
  ];

  @override
  void initState() {
    setUpProvider();
    super.initState();
  }

  Future<void> setUpProvider() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    await userProvider.setUserInProvider().then((value) => setState(() {
          user = userProvider.getUser;
        }));
  }

  @override
  Widget build(BuildContext context) {
    print('Home screen widget built');

    if (user != null) {
      if (user!.email == "admin@admin.com" && containers.length == 5) {
        setState(() {
          containers.add(const ButtonWithContext());
        });
      }
    }

    return (user == null)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: const CustomAppBar(),
            body: ListView.separated(
              padding: const EdgeInsets.all(15),
              itemCount: containers.length,
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemBuilder: (context, index) {
                return containers[index];
              },
            ));
  }
}

class ButtonWithContext extends StatelessWidget {
  const ButtonWithContext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AdminScreen()));
        },
        child: const Text('Przejdź do panelu admina'));
  }
}

class ListTab extends StatelessWidget {
  final String gameType;
  final String gameTypeToDisplay;
  final Color backgroundUrl;

  const ListTab({
    super.key,
    required this.gameType,
    required this.backgroundUrl,
    required this.gameTypeToDisplay,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<GameProvider>(context, listen: false).setGameType(gameType);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const ChooseModeScreen(),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
                color: backgroundUrl),
            padding: const EdgeInsets.only(bottom: 10),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              gameTypeToDisplay,
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
