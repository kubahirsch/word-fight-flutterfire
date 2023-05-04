import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/screens_for_single_player/end_of_round_single.dart';

import '../providers/question_provider.dart';
import '../utils/colors.dart';
import '../widgets/custom_percent_indicator.dart';

class Question4Single extends StatefulWidget {
  const Question4Single({super.key});

  @override
  State<Question4Single> createState() => _Question4SingleState();
}

class _Question4SingleState extends State<Question4Single> {
  final synonymController = TextEditingController();
  List<String> addedSynonyms = [];
  bool isHolding = false;

  @override
  void initState() {
    Timer(const Duration(seconds: 15), () async {
      if (mounted) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const EndOfRoundSingle(),
        ));
      }
    });
    super.initState();
  }

  void checkSynonym(
      List<dynamic> synonyms, String inputSynonym, BuildContext context) {
    if (synonyms.contains(inputSynonym) &&
        !(addedSynonyms.contains(inputSynonym))) {
      Provider.of<QuestionProvider>(context, listen: false).changePoints(5);
      setState(() {
        addedSynonyms.add(inputSynonym);
      });
      showDialog(
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          return const AlertDialog(
            shape: CircleBorder(),
            title: Center(child: Text('+5')),
            backgroundColor: Color.fromARGB(255, 47, 189, 52),
          );
        },
      );
    } else {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });

          return const AlertDialog(
            shape: CircleBorder(),
            title: Center(child: Text('X')),
            backgroundColor: Colors.red,
          );
        },
      );
    }
  }

  @override
  void dispose() {
    synonymController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> questionData =
        Provider.of<QuestionProvider>(context, listen: false)
            .getQuestionDataAsMap;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              '${questionData['word'].toUpperCase()}',
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CustomPercentIndicator(animationDuration: 15000),
            const SizedBox(height: 40),
            TextField(
              controller: synonymController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintText: 'Podaj synonim...',
              ),
            ),
            const SizedBox(height: 60),
            ButtonWithHold(
              width: double.infinity,
              height: 50,
              onTap: () {
                checkSynonym(questionData['synonyms'],
                    synonymController.text.toLowerCase(), context);
                synonymController.clear();
              },
              text: 'Sprawdź',
            ),
            const SizedBox(height: 40),
            ButtonWithHold(
              onTap: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const EndOfRoundSingle(),
                ));
              },
              text: 'Nie znam więcej synonimów',
              width: double.infinity,
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonWithHold extends StatefulWidget {
  final void Function() onTap;
  final double? width;
  final double? height;
  final String text;
  const ButtonWithHold({
    super.key,
    required this.onTap,
    required this.text,
    required this.width,
    required this.height,
  });

  @override
  State<ButtonWithHold> createState() => ButtonWithHoldState();
}

class ButtonWithHoldState extends State<ButtonWithHold> {
  bool isHolding = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHighlightChanged: (value) {
        if (value) {
          setState(() {
            isHolding = true;
          });
        } else {
          setState(() {
            isHolding = false;
          });
        }
      },
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            color: isHolding ? Colors.black : Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        width: widget.width,
        height: widget.height,
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: 18, color: isHolding ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
