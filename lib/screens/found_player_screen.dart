import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wordfight/screens_with_questions.dart/question1_screen.dart';

class FoundPlayer extends StatefulWidget {
  const FoundPlayer({super.key});

  @override
  State<FoundPlayer> createState() => _FoundPlayerState();
}

class _FoundPlayerState extends State<FoundPlayer> {
  bool loadPage = true;

  @override
  void initState() {
    Timer(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          loadPage = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loadPage
        ? const Scaffold(
            body: Center(
              child: Text(
                  'Zaleźliśmy dla ciebie gracza ! Zaraz przekierujemy cię do pierwszego pytania !'),
            ),
          )
        : const Question1();
  }
}
