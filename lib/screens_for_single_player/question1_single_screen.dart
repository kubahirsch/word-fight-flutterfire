import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/screens_for_single_player/question2_single_screen.dart';

import '../providers/question_provider.dart';
import '../providers/swipe_provider.dart';
import '../utils/colors.dart';
import '../widgets/icon_container.dart';
import '../widgets/word_container.dart';
import 'end_of_round_single.dart';

class Question1Single extends StatefulWidget {
  const Question1Single({super.key});

  @override
  State<Question1Single> createState() => _Question1SingleState();
}

class _Question1SingleState extends State<Question1Single> {
  late String gameType;
  int? numOfQuestionsAvaible;
  bool knowWord = false;

  @override
  void initState() {
    setVariables();
    super.initState();
  }

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  void setVariables() async {
    gameType = Provider.of<GameProvider>(context, listen: false).getGameType;
    var querySnap =
        await FirebaseFirestore.instance.collection(gameType).count().get();
    setState(() {
      numOfQuestionsAvaible = querySnap.count;
    });
  }

  @override
  Widget build(BuildContext context) {
    SwipeProvider swipeProvider =
        Provider.of<SwipeProvider>(context, listen: false);
    MatchEngine matchEngine = MatchEngine(swipeItems: [
      SwipeItem(likeAction: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Question2Single(),
          ),
        );
      }, nopeAction: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const EndOfRoundSingle(),
        ));
      }, onSlideUpdate: (SlideRegion? region) async {
        if (region == SlideRegion.inNopeRegion) {
          swipeProvider.setSelection('left');
        }
        if (region == null) {
          swipeProvider.clearSelection();
        }
        if (region == SlideRegion.inLikeRegion) {
          swipeProvider.setSelection('right');
        }
      })
    ]);

    return (numOfQuestionsAvaible == null)
        ? const Center(
            child: CircularProgressIndicator(color: Colors.amber),
          )
        : FutureBuilder(
            future: Provider.of<QuestionProvider>(context, listen: false)
                .setQuestionDataInProvider(
                    random(0, numOfQuestionsAvaible!), gameType),
            builder: (BuildContext context, var snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                QuestionProvider questionProvider =
                    Provider.of<QuestionProvider>(context, listen: false);
                questionProvider.zeroPoints();
                Map<String, dynamic>? questionData =
                    questionProvider.getQuestionDataAsMap;
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                  ),
                  body: Column(
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        'Czy znasz wyraz:',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: 300,
                        width: 400,
                        child: SwipeCards(
                            matchEngine: matchEngine,
                            onStackFinished: () {},
                            itemBuilder: (context, index) {
                              return WordContainer(
                                word: questionData['word'],
                              );
                            }),
                      ),
                      const SizedBox(height: 50),
                      Row(
                        children: [
                          const Spacer(flex: 3),
                          Consumer<SwipeProvider>(
                            builder: (_, value, __) {
                              return IconContainer(
                                icon: Icons.close,
                                isSelected: value.getIsLeftSelected,
                              );
                            },
                          ),
                          const Spacer(),
                          Consumer<SwipeProvider>(
                            builder: (_, value, __) {
                              return IconContainer(
                                icon: Icons.done,
                                isSelected: value.getIsRightSelected,
                              );
                            },
                          ),
                          const Spacer(flex: 3),
                        ],
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.amber),
                );
              }
            });
  }
}
