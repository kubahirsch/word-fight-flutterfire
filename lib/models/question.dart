import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question {
  final String gameType;
  final String word;
  final String ansA;
  final String ansB;
  final String ansC;
  final String ansD;
  final String correctAns;
  final String sentence1;
  final String sentence2;
  final String sentence3;
  final String correctSentence;
  final List<String> synonyms;
  final int id;

  Question({
    required this.gameType,
    required this.word,
    required this.ansA,
    required this.ansB,
    required this.ansC,
    required this.ansD,
    required this.correctAns,
    required this.sentence1,
    required this.sentence2,
    required this.sentence3,
    required this.correctSentence,
    required this.synonyms,
    required this.id,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'gameType': gameType,
      'word': word,
      'a': ansA,
      'b': ansB,
      'c': ansC,
      'd': ansD,
      'correct': correctAns,
      'sentence1': sentence1,
      'sentence2': sentence2,
      'sentence3': sentence3,
      'correctSentence': correctSentence,
      'synonyms': synonyms,
      'id': id
    };
  }
}
