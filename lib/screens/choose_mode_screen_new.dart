// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wordfight/screens/random_player_screen.dart';
import 'package:wordfight/screens/single_player_screen.dart';
import 'package:wordfight/screens/with_friend_screen.dart';

import '../widgets/appbar.dart';

class ChooseModeScreen extends StatelessWidget {
  const ChooseModeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    print('choose mode widget built ');

    PageController pageController =
        PageController(viewportFraction: 0.8, initialPage: 1);

    return Scaffold(
        appBar: const CustomAppBar(),
        body: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Wybierz tryb gry',
                  style: TextStyle(fontFamily: 'Playfair', fontSize: 35),
                ),
              ),
            ),
            SizedBox(
              height: 520,
              child: PageView(
                controller: pageController,
                children: const [
                  GameTypeContainer(
                    contentText:
                        'Gra ma 3 rundy \nKażda runda to 1 słowo \nSą minusowe i dodatnie punkty',
                    gameType: 'Losowy \nprzeciwnik',
                    nextScreen: RandomPlayerScreen(),
                  ),
                  GameTypeContainer(
                    contentText:
                        'Gra ma 1 rundę \nKażda runda to 1 słowo \nSą minusowe i dodatnie punkty',
                    gameType: 'Graj sam',
                    nextScreen: SinglePlayerScreen(),
                  ),
                  GameTypeContainer(
                    contentText:
                        'Gra ma 3 rundy \nKażda runda to 1 słowo \nSą minusowe i dodatnie punkty',
                    gameType: 'Graj z \nprzyjacielem',
                    nextScreen: WithFriendScreen(),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SmoothPageIndicator(
              controller: pageController,
              count: 3,
              axisDirection: Axis.horizontal,
              effect: const WormEffect(
                  spacing: 8.0,
                  radius: 10.0,
                  dotWidth: 20.0,
                  dotHeight: 20.0,
                  paintStyle: PaintingStyle.stroke,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.black),
            ),
          ],
        ));
  }
}

class GameTypeContainer extends StatelessWidget {
  final String gameType;
  final String contentText;
  final Widget nextScreen;
  const GameTypeContainer({
    Key? key,
    required this.gameType,
    required this.nextScreen,
    required this.contentText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => nextScreen,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
          ),
          child: Column(
            children: [
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    gameType,
                    style: const TextStyle(
                        fontSize: 40, fontFamily: "Oswald", height: 1),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    contentText,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.done, size: 60),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
