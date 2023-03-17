import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/providers/question_provider.dart';
import 'package:wordfight/providers/user_provider.dart';
import 'package:wordfight/screens/choose_mode_screen.dart';
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
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => QuestionProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GameProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: backgroundGrey,
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(buttonYellow),
              minimumSize: MaterialStateProperty.all(const Size(200, 50)),
            )),
            textTheme: const TextTheme(
                bodyMedium: TextStyle(fontSize: 20, color: Colors.white)),
          ),
          home: const ChooseMode()),
    );
  }
}
