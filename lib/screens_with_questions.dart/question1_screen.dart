import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';
import 'package:wordfight/screens/end_of_round_screen.dart';
import 'package:wordfight/screens_with_questions.dart/question2_screen.dart';

import '../providers/swipe_provider.dart';
import '../widgets/icon_container.dart';
import '../widgets/word_container.dart';

class Question1 extends StatefulWidget {
  const Question1({super.key});

  @override
  State<Question1> createState() => _Question1State();
}

class _Question1State extends State<Question1> {
  @override
  Widget build(BuildContext context) {
    GameProvider gameProvider =
        Provider.of<GameProvider>(context, listen: false);
    SwipeProvider swipeProvider =
        Provider.of<SwipeProvider>(context, listen: false);

    MatchEngine matchEngine = MatchEngine(swipeItems: [
      SwipeItem(likeAction: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const Question2(),
        ));
      }, nopeAction: () async {
        await gameProvider.refreshGameDataInProvider(gameProvider.getMyGame!);
        await FirestoreMethods().incrementUserRound(
            gameProvider.getMyGame!, gameProvider.getUserId);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const EndOfRound(),
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

    return (gameProvider.gameSnap == null)
        ? const Center(child: CircularProgressIndicator())
        : FutureBuilder(
            future: Provider.of<QuestionProvider>(context, listen: false)
                .setQuestionDataInProvider(
                    gameProvider.gameSnap!['questionsIds']
                        [(gameProvider.getRoundNumber)],
                    gameProvider.getGameType),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic>? questionData =
                    Provider.of<QuestionProvider>(context, listen: false)
                        .getQuestionDataAsMap;
                return Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    centerTitle: true,
                    title: const Text('Pierwsze pytanie'),
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
            },
          );
  }
}

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  const CustomButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size.fromHeight(100))),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}
