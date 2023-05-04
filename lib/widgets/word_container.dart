import 'package:flutter/material.dart';

class WordContainer extends StatelessWidget {
  final String word;
  const WordContainer({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        height: 350,
        width: 300,
        child: Column(
          children: [
            Text(
              word,
              style: const TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}
