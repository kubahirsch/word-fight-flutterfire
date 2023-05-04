import 'package:flutter/material.dart';

class ResultContainer extends StatelessWidget {
  final String sentence;
  final bool isCorrect;
  const ResultContainer(
      {super.key, required this.sentence, required this.isCorrect});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 5,
                blurRadius: 5,
              )
            ],
            color: isCorrect ? Colors.green : Colors.red,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Text(sentence),
              const Spacer(),
              isCorrect
                  ? const Text(
                      '+2',
                      style: TextStyle(fontSize: 25),
                    )
                  : const Text(
                      '-2',
                      style: TextStyle(fontSize: 25),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
