import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/resources/auth_methods.dart';
import 'package:wordfight/screens/choose_mode_screen.dart';
import 'package:wordfight/models/user.dart' as model;
import 'package:wordfight/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    setUpProvider();
    super.initState();
  }

  void setUpProvider() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    userProvider.setUserInProvider();
  }

  List<Widget> containers = [
    const ListTab(gameType: 'polishWordsEasy', backgroundUrl: Colors.amber),
    const ListTab(gameType: 'polishWordsHard', backgroundUrl: Colors.black),
    const ListTab(gameType: 'englishWordsA1', backgroundUrl: Colors.white),
    const ListTab(gameType: 'englishWordsA2', backgroundUrl: Colors.blue),
  ];

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    model.User? user = userProvider.getUser;
    return (user == null)
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  },
                  child:
                      (FirebaseAuth.instance.currentUser!.isAnonymous == true)
                          ? const CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/default_profile_pic.png'),
                            )
                          : CircleAvatar(
                              backgroundImage: NetworkImage(user.photoUrl),
                            ),
                )
              ],
              title: const Text('Home screen'),
            ),
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

class ListTab extends StatelessWidget {
  final String gameType;
  final Color backgroundUrl;

  const ListTab({
    super.key,
    required this.gameType,
    required this.backgroundUrl,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ChooseMode(
              gameType: gameType,
            ),
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 90,
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
            child: Text(gameType),
          ),
        ],
      ),
    );
  }
}
