import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wordfight/screens/login_screen.dart';

import 'home_screen.dart';

class DeicisionTree extends StatefulWidget {
  const DeicisionTree({super.key});

  @override
  State<DeicisionTree> createState() => _DeicisionTreeState();
}

class _DeicisionTreeState extends State<DeicisionTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          var user = snapshot.data;
          if (user != null) {
            print(user);
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
