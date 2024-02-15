import 'package:flutter/material.dart';

class ChatbotWidget extends StatefulWidget {
  @override
  _ChatbotWidgetState createState() => _ChatbotWidgetState();
}

class _ChatbotWidgetState extends State<ChatbotWidget> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _redirectToChatPage() {
    String text = _textEditingController.text;
    // Redirect to another page with the text information
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(text: text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatbot'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                labelText: 'Enter your text',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _redirectToChatPage,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  final String text;

  const ChatPage({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Page'),
      ),
      body: Center(
        child: Text('You entered: $text'),
      ),
    );
  }
}
