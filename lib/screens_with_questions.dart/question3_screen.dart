import 'dart:async';

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:wordfight/screens/one_finished_screen.dart';
import 'package:wordfight/screens_with_questions.dart/question4_screen.dart';

class Question3 extends StatefulWidget {
  const Question3({super.key});

  @override
  State<Question3> createState() => _Question3State();
}

class _Question3State extends State<Question3> {
  List<bool> visability = [true, true, true, true];

  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const Question4(),
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(height: 100),
        LinearPercentIndicator(
          percent: 1,
          animation: true,
          animationDuration: 5000,
          lineHeight: 20,
          backgroundColor: Colors.grey,
          progressColor: Colors.amber,
        ),
        const Text(
            'W tej rundzie musisz powiedzieć czy zdanie jest poprawnie użyte. Za każdą poprawną odpowiedź dostajesz 3 pkt, a za zła -4'),
        const SizedBox(height: 50),
        if (visability[0])
          Row(
            children: const [
              Text('Zdanie 1'),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Text('tak'),
                ),
              ),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Text('nie'),
                ),
              ),
            ],
          ),
        if (visability[1])
          Row(
            children: const [
              Text('Zdanie 1'),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Text('tak'),
                ),
              ),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Text('nie'),
                ),
              ),
            ],
          ),
        if (visability[2])
          Row(
            children: const [
              Text('Zdanie 1'),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Text('tak'),
                ),
              ),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Text('nie'),
                ),
              ),
            ],
          ),
        if (visability[3])
          Row(
            children: const [
              Text('Zdanie 1'),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Text('tak'),
                ),
              ),
              InkWell(
                child: SizedBox(
                  width: 50,
                  height: 20,
                  child: Text('nie'),
                ),
              ),
            ],
          ),
        //Zamiast tego guzika w przyszłości powinien być timer
        InkWell(
          onTap: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => const Question4(),
            ));
          },
          child: const Text('Przejdź do następnego pytania'),
        ),
      ],
    ));
  }
}
