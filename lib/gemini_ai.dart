import 'package:chatbot/chat_content.dart';
import 'package:flutter/material.dart';

class GeminiAI extends StatelessWidget {
  const GeminiAI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xffDDF2FD),
        appBar: AppBar(
          title: const Text(
            "Gemini AI",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xff2E4374),
        ),
        body: const ChatContent(),
      );
}
