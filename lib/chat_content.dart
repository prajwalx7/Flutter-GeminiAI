import 'package:chatbot/message_content.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatContent extends StatefulWidget {
  const ChatContent({Key? key}) : super(key: key);

  @override
  State<ChatContent> createState() => _ChatContentState();
}

class _ChatContentState extends State<ChatContent> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final _scrollController = ScrollController();
  final _textController = TextEditingController();
  final _textFieldFocus = FocusNode();
  bool _loading = false;
  // bool _chatStarted = false;
  static const _apiKey = "API Key";

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(model: 'gemini-pro', apiKey: _apiKey);
    _chat = _model.startChat();
    // _chatStarted = false;
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 750),
          curve: Curves.easeOutCirc,
        );
      });
    });
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      var response = await _chat.sendMessage(Content.text(message));
      var text = response.text;

      if (text == null) {
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _scrollDown();
          _loading = false;
        });
      }
    } catch (e) {
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (!_chatStarted) {
    //   return Align(
    //     alignment: Alignment.center,
    //     child: Lottie.asset(
    //       "assets/animation/chatbot.json",
    //       height: 300,
    //       width: 300,
    //       fit: BoxFit.fill,
    //     ),
    //   );
    // }
    var textFieldDecoration = InputDecoration(
      contentPadding: const EdgeInsets.all(20),
      hintText: 'Message Gemini...',
      hintStyle: const TextStyle(
        color: Colors.black38,
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
        borderSide: BorderSide(
          color: Colors.black54,
        ),
      ),
      suffixIcon: _loading
          ? const Padding(
              padding: EdgeInsets.all(12.0),
              child: CircularProgressIndicator(
                color: Color(
                  0xff465262,
                ),
                strokeWidth: 4,
                strokeCap: StrokeCap.round,
              ),
            )
          : IconButton(
              onPressed: () async {
                _sendChatMessage(_textController.text);
                _textFieldFocus.unfocus();
              },
              icon: Icon(
                Icons.arrow_circle_up_sharp,
                color: Theme.of(context).colorScheme.secondary,
                size: 35,
              ),
            ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _apiKey.isNotEmpty
                ? ListView.builder(
                    controller: _scrollController,
                    itemBuilder: (context, idx) {
                      var content = _chat.history.toList()[idx];
                      var text = content.parts
                          .whereType<TextPart>()
                          .map<String>((e) => e.text)
                          .join('');
                      return MessageContent(
                        text: text,
                        isFromUser: content.role == 'user',
                      );
                    },
                    itemCount: _chat.history.length,
                  )
                : ListView(
                    children: const [
                      Text('Please provide a valid API key'),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 5, right: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _textFieldFocus,
                    decoration: textFieldDecoration,
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    controller: _textController,
                    onSubmitted: (String value) {
                      _sendChatMessage(value);
                      _textFieldFocus.unfocus();
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
