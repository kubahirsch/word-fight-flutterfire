import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens_with_questions.dart/question2_screen.dart';

class CurrentScore extends StatefulWidget {
  const CurrentScore({super.key});

  @override
  State<CurrentScore> createState() => _CurrentScoreState();
}

class _CurrentScoreState extends State<CurrentScore> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Question2(),
        ));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          Text(
              'Twoje punkty  : ${userProvider.gameSnap!['points_${userProvider.getUserId}']}'),
          Text(
              'Punkty przeciwnika  : ${userProvider.gameSnap!['points_${userProvider.getRivalId}']}'),
        ],
      )),
    );
  }
}
