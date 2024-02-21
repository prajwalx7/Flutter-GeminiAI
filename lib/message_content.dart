import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageContent extends StatelessWidget {
  final String text;
  final bool isFromUser;

  const MessageContent({
    Key? key,
    required this.text, // Define the 'text' parameter here
    required this.isFromUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: isFromUser
                  ? const Color(0xff465262)
                  : const Color(0xffE3E1D9),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 15,
            ),
            margin: const EdgeInsets.only(top: 10, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isFromUser)
                  const Text(
                    'Gemini AI : ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                const SizedBox(height: 5),
                MarkdownBody(
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      color: isFromUser ? Colors.white : Colors.black,
                      fontSize: 15,
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
