import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [];
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages.add({
      "text": "Hello Manu! 😊\nI am bot, your guide.\nHow can I help you today?",
      "isUser": false,
      "buttons": ["Hello", "Tell me", "More Options"],
    });
  }

  void _sendMessage(String text) {
    setState(() {
      _messages.add({"text": text, "isUser": true});
    });
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _messages.add({
          "text":
          "Hello Manu! 😊\nI am bot, your guide.\nHow can I help you today?",
          "isUser": false,
          "buttons": ["Hello", "Tell me", "More Options"],
        });
      });
    });
  }

  void _handleButtonClick(String buttonText) {
    setState(() {
      // Add the user's selection as a message
      _messages.add({"text": buttonText, "isUser": true});
    });

    String response = "";
    List<String> buttons = [];

    switch (buttonText) {
      case "Hello":
        response = "How are you?";
        buttons = ["Good", "Not So Good"];
        break;
      case "Tell me":
        response = "What do you want to do?";
        buttons = ["Anything interesting", "Nothing"];
        break;
      case "More Options":
        response =
        "Here are more options to help you. What would you like to explore?";
        buttons = ["Help Center", "Contact Support", "FAQ"];
        break;
      default:
        response = "How can I assist you further?";
        break;
    }

    setState(() {
      _messages.add({"text": response, "isUser": false, "buttons": buttons});
    });
  }

  Widget _buildMessage(Map<String, dynamic> message) {
    return Align(
      alignment:
      message['isUser'] ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: message['isUser'] ? Colors.green[800] : Colors.grey[800],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['text'],
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            if (message.containsKey('buttons'))
              Wrap(
                spacing: 10,
                children: message['buttons'].map<Widget>((buttonText) {
                  return ElevatedButton(
                    onPressed: () => _handleButtonClick(buttonText),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    child: Text(buttonText),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bot Demo"),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessage(_messages.reversed.toList()[index]);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
    );
  }

  Widget _buildInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      color: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.tealAccent),
            onPressed: () {
              if (_controller.text.trim().isNotEmpty) {
                _sendMessage(_controller.text.trim());
                _controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
