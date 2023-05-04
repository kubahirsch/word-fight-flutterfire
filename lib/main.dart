import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/providers/swipe_provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens/choose_mode_screen.dart';
import 'package:wordfight/screens/decision_tree.dart';
import 'package:wordfight/screens/home_screen.dart';
import 'package:wordfight/utils/colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuestionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => SwipeProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: bezowy,
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: bezowy,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          textTheme:
              const TextTheme(bodyMedium: TextStyle(fontFamily: 'Playfair')),
        ),
        home: const DeicisionTree(),
        routes: {
          '/homeScreen': (BuildContext context) => const HomeScreen(),
        },
      ),
    );
  }
}
