import 'package:flutter/material.dart';
import 'gemini_ai.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textSelectionTheme: const TextSelectionThemeData(
            selectionColor: Color(0xff40A2D8),
            selectionHandleColor: Color(0xff40A2D8),
          ),
        ),
        home: const GeminiAI(),
      );
}
