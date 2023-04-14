import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/resources/question_methods.dart';
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
        title: const Text('Czwarte pytanie'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const CustomPercentIndicator(animationDuration: 15000),
            const SizedBox(height: 40),
            Text(
              'W tej rundzie musisz podać jak najwięcej synonimów do słowa: ${questionData['word'].toUpperCase()}',
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Za każdy synonim dostajesz 3 pkt',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            TextField(
              controller: synonymController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: buttonYellow)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: buttonHoverYellow)),
                hintText: 'synonim',
              ),
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 32, horizontal: 20)),
              onPressed: () {
                checkSynonym(questionData['synonyms'],
                    synonymController.text.toLowerCase(), context);
                synonymController.clear();
              },
              child: const Text('Sprawdź !'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
