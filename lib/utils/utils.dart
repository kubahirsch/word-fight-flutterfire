import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:wordfight/providers/game_provider.dart';
import 'package:wordfight/resources/firestore_methods.dart';

pickImage(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }

  print('Nie wybrano zdjęcia');
}

showSnackBar(String content, BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

void deleteIfInGame(BuildContext context) {
  GameProvider gameProvider = Provider.of<GameProvider>(context);
  if (gameProvider.getMyGame != null) {
    FirestoreMethods()
        .deleteGame(Provider.of<GameProvider>(context).getMyGame!);
    print('${gameProvider.getMyGame} game deleted');
    gameProvider.setGameId(null);
  }
}

String gameTypeToDisplay(BuildContext context) {
  String gameType = Provider.of<GameProvider>(context).getGameType;

  switch (gameType) {
    case 'questions':
      return 'Wyszukane polskie wyrazy';

    case 'questionsPolishEasy':
      return 'Łatwe polskie wyrazy';

    case 'questionsEnglishA1':
      return 'Angielskie wyrazy A1';

    case 'questionsEnglishA2':
      return 'Angielskie wyrazy A2';

    default:
      return 'Wrong game type';
  }
}
