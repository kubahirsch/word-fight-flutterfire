import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';

import '../models/user.dart ' as model;
import '../resources/auth_methods.dart';
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
    UserProvider userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: const BoxDecoration(color: Colors.amber),
              ),
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                    ),
                    const Text(
                      'huj tararae',
                      style: TextStyle(fontSize: 40),
                    ),
                    const Text('asdf'),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: signOut,
                      child: const Text("Wyloguj się "),
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            decoration: const BoxDecoration(color: Colors.black),
            child: Row(
              children: [
                Column(
                  children: const [Text('Ilość wygranych'), Text('123')],
                ),
                Column(
                  children: const [Text('Ilość przegranych'), Text('23')],
                ),
              ],
            ),
          ),
          ListView(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.cyan,
                  ),
                  Text('player 123')
                ],
              ),
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.cyan,
                  ),
                  Text('player 123')
                ],
              ),
              Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.cyan,
                  ),
                  Text('player 123')
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
