import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wordfight/models/user.dart';
import 'package:wordfight/providers/user_provider.dart';

import '../resources/auth_methods.dart';
import '../utils/colors.dart';
import '../utils/utils.dart';
import 'decision_tree.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void signOut() async {
    String res = await AuthMethods().signOut();

    if (res != 'success' && mounted) {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DeicisionTree()));
    }
  }

  @override
  Widget build(BuildContext context) {
    User? userData = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.6,
            decoration: const BoxDecoration(
              color: Colors.black,
              // image: DecorationImage(
              //     image: AssetImage('assets/black_background.jpg'),
              //     fit: BoxFit.cover),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40)),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: const BoxDecoration(
                          color: bezowy,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(40))),
                    ),
                    Positioned(
                      left: 15,
                      bottom: 15,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(userData!.photoUrl),
                          ),
                          Text(
                            (userData.email == '')
                                ? userData.username
                                : 'NewPlayer',
                            style: const TextStyle(fontSize: 40),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LogOutElevatedButton(
                              onPressed: signOut, text: 'Wyloguj się')
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Spacer(),
                      Row(
                        children: const [
                          Spacer(),
                          ColumnWithGamesPlayed(
                            text1: 'Wygrane',
                            text2: '123',
                          ),
                          Spacer(),
                          ColumnWithGamesPlayed(
                            text1: 'Przegrane',
                            text2: '12',
                          ),
                          Spacer(),
                          ColumnWithGamesPlayed(
                            text1: 'Znajomi',
                            text2: '12',
                          ),
                          Spacer(),
                        ],
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'LISTA ZNAJOMYCH',
              style: TextStyle(
                  fontFamily: 'Oswald',
                  color: Color.fromARGB(255, 80, 80, 80),
                  fontSize: 20),
            ),
          ),
          Expanded(
            // muszę usunąć expanded żeby działało, ale wtedy jest problem z overflowed pixels
            child: SingleChildScrollView(
              child: ListView(
                shrinkWrap: true,
                children: const [
                  FriendTab(username: 'Maciek', profileUrl: 'asdf'),
                  FriendTab(username: 'Ola', profileUrl: 'asdf'),
                  FriendTab(username: 'Michał', profileUrl: 'asdf'),
                  FriendTab(username: 'Kuba', profileUrl: 'asdf'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FriendTab extends StatelessWidget {
  final String username;
  final String profileUrl;
  const FriendTab({
    super.key,
    required this.username,
    required this.profileUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: CircleAvatar(
            backgroundColor: Colors.cyan,
          ),
        ),
        Text(
          username,
          style: const TextStyle(fontFamily: 'Oswald', fontSize: 17),
        ),
      ],
    );
  }
}

class ColumnWithGamesPlayed extends StatelessWidget {
  final String text1;
  final String text2;
  const ColumnWithGamesPlayed({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text1,
          style: const TextStyle(color: Colors.grey, fontFamily: 'Oswald'),
        ),
        Text(
          text2,
          style: const TextStyle(
            height: 1.1,
            fontFamily: 'Oswald',
            fontSize: 45,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

class LogOutElevatedButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const LogOutElevatedButton(
      {super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          minimumSize: const Size(200, 50),
          side: const BorderSide(
            color: Colors.black,
          ),
          shape: const RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.only(bottomLeft: Radius.circular(40)))),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}
