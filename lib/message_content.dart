import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageContent extends StatelessWidget {
  final String text;
  final bool userInput;

  const MessageContent({
    Key? key,
    required this.text,
    required this.userInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          userInput ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color:
                  userInput ? const Color(0xff465262) : const Color(0xff9BBEC8),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!userInput)
                  const Text(
                    'Gemini AI :',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                const SizedBox(height: 5),
                MarkdownBody(
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: userInput ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  selectable: true,
                  data: text,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
