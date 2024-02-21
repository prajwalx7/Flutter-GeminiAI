import 'package:chatbot/chat_content.dart';
import 'package:flutter/material.dart';

class GenerativeAISample extends StatelessWidget {
  const GenerativeAISample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Gemini AI",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xff2E4374),
        ),
        body: const ChatContent(),
      );
}
// AIzaSyAhsmG6W1XiBeiUQevpsRjbi4HaNAacqDM