import 'package:flutter/material.dart';

class RivalLeftScreen extends StatelessWidget {
  const RivalLeftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text(
                'Gra już nie istnieje, prawdopodobnie Twój rywal opuścił rozgrywkę'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .popUntil(ModalRoute.withName('/homeScreen'));
              },
              child: const Text('Ekran główny'),
            )
          ],
        ),
      ),
    );
  }
}
