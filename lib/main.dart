import 'package:flutter/material.dart';
import 'generative_ai_sample.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff465262)),
          useMaterial3: true,
        ),
        home: const GenerativeAISample(),
      );
}
