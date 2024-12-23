import 'package:flutter/material.dart';

import 'chat_screen.dart';

void main() {
  runApp(ChatBotApp());
}

class ChatBotApp extends StatelessWidget {
  const ChatBotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ChatScreen(),
    );
  }
}