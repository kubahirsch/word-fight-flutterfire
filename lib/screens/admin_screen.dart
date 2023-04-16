//This Screen I created with chat gpt

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wordfight/models/question.dart';
import 'package:wordfight/utils/create_fields_in_db.dart';
import 'package:wordfight/utils/utils.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final _formKey = GlobalKey<FormState>();
  String? word;
  String? ansA;
  String? ansB;
  String? ansC;
  String? ansD;
  String? correctAns;
  String? sentence1;
  String? sentence2;
  String? sentence3;
  String? correctSentence;
  List<String>? synonyms;
  String? gameType;

  List<DropdownMenuItem> dropdownMenuItems = [
    const DropdownMenuItem(
        value: 'questions', child: Text('Trudne polskie wyrazy')),
    const DropdownMenuItem(
        value: 'questionsPolishEasy', child: Text('Łatwe polskie wyrazy')),
    const DropdownMenuItem(
        value: 'questionsEnglishA1', child: Text('A1 angielskie wyrazy')),
    const DropdownMenuItem(
        value: 'questionsEnglishA2', child: Text('A2 angielskie wyrazy')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin panel'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Podaj wyraz'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => word = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Podaj odpowiedź A'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => ansA = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Podaj odpowiedź B'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => ansB = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Podaj odpowiedź C'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => ansC = value,
              ),
              TextFormField(
                decoration:
                    const InputDecoration(labelText: 'Podaj odpowiedź D'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => ansD = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText:
                        'Która z tych odpowiedzi jest poprawna (podaj literę)'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => correctAns = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Podaj 1 zdanie'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => sentence1 = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Podaj 2 zdanie'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => sentence2 = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Podaj 3 zdanie'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => sentence3 = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText: 'Które z tych zdań jest poprawne'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => correctSentence = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                    labelText:
                        'Podaj synonimy ze spacją jako oddzielenie spacji'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Proszę uzupełnij to pole';
                  }
                  return null;
                },
                onSaved: (value) => synonyms = value!.split(' '),
              ),
              DropdownButtonFormField(
                  value: 'questions',
                  items: dropdownMenuItems,
                  onChanged: (value) {
                    setState(() {
                      gameType = value;
                    });
                  }),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    var snap = await FirebaseFirestore.instance
                        .collection(gameType!)
                        .count()
                        .get();
                    int id = snap.count;
                    String res = await createNewWord(
                      Question(
                        gameType: gameType!,
                        word: word!,
                        ansA: ansA!,
                        ansB: ansB!,
                        ansC: ansC!,
                        ansD: ansD!,
                        correctAns: correctAns!,
                        sentence1: sentence1!,
                        sentence2: sentence2!,
                        sentence3: sentence3!,
                        correctSentence: correctSentence!,
                        synonyms: synonyms!,
                        id: id,
                      ),
                    );
                    if (res != 'success' && mounted) {
                      showSnackBar(res, context);
                    } else {
                      showSnackBar('Wyraz dodany!', context);
                    }
                  }
                },
                child: const Text('Dodaj słowo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
