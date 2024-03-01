import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhraseScreens(),
    );
  }
}

class PhraseScreens extends StatefulWidget {
  @override
  _PhraseScreensState createState() => _PhraseScreensState();
}

class _PhraseScreensState extends State<PhraseScreens> {
  int _currentIndex = 0;

  final List<String> phrases = [
    "Quem tem luz própria jamais ficará na escuridão.",
    "Qualquer objetivo que você planta, a vida floresce com graça.",
    "Qualquer objetivo que você planta, a vida floresce com graça.",
    "Se quiser alcançar a grandeza, pare de pedir permissão.",
    "Mentes poderosas têm objetivos, as demais têm desejos."
  ];

  void _changeScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Frases do Dia'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              phrases[_currentIndex],
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < phrases.length; i++)
                  ElevatedButton(
                    onPressed: () => _changeScreen(i),
                    child: Text('Tela ${i + 1}'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
