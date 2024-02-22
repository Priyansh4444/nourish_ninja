import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nourish_ninja/user_data.dart';

// Add a TextEditingController
final TextEditingController textEditingController = TextEditingController();


Future<Map<String, String>> parseStringToMap(
    {String assetsFileName = '.env'}) async {
  final lines = await rootBundle.loadString(assetsFileName);
  Map<String, String> environment = {};
  for (String line in lines.split('\n')) {
    line = line.trim();
    if (line.contains('=') //Set Key Value Pairs on lines separated by =
        &&
        !line.startsWith(RegExp(r'=|#'))) {
      //No need to add emty keys and remove comments
      List<String> contents = line.split('=');
      environment[contents[0]] = contents.sublist(1).join('=');
    }
  }
  return environment;
}

Future<String?> responds(String input) async {
  // Access your API key as an environment variable (see "Set up your API key" above)
   await dotenv.load(fileName: ".env");
final apiKey = dotenv.env['API_KEY'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
  }
  // For text-only input, use the gemini-pro model
  final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey!,
      generationConfig: GenerationConfig(maxOutputTokens: 1800));
  // Initialize the chat
  final chat = model.startChat(history: [
    Content.text(
        'Hello you are a Master nutritoinist and cook, you have roleplaying as a ninja. in 1800 tokens'),
    Content.model(
        [TextPart('I am a nutritionist and I can help you with your diet!!!')]),
  ]);
  var content = Content.text(input);
  var response = await chat.sendMessage(content);
  print(response.text);
  return (response.text);
}

class Message {
  final String text;
  final bool isAi;

  Message({required this.text, required this.isAi});
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isAi;

  const MessageBubble({required this.text, required this.isAi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAi ? Colors.grey[300] : Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isAi ? Colors.black : Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}

class ChatUI extends StatefulWidget {
  static String routeName = "/chat";
  @override
  _ChatUIState createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  List<Message> messages = [
    Message(text: 'Hello! How can I assist you today?', isAi: true),
  ];

  TextEditingController _textEditingController =
      TextEditingController(); // Add a TextEditingController

  @override
  Widget build(BuildContext context) {
    var message = ''; // Declare the 'message' variable

    print('Building ChatUI'); // Replace with a logging framework

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Chatbot'), // Add 'const' keyword for improved performance
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageBubble(
                  text: message.text,
                  isAi: message.isAi,
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8), // Add 'const' keyword for improved performance
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller:
                        _textEditingController, // Assign the TextEditingController
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (text) {
                      setState(() {
                        print('Message changed: $text');
                        message = text ??
                            ''; // Update the 'message' variable with a null check
                        print(message);
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    setState(() {
                      final newMessage = Message(text: _textEditingController.text, isAi: false);
                      messages.add(newMessage);
                      message = _textEditingController.text;
                      _textEditingController.clear();
                      print('User Message: $message');
                    });
                    if (message.contains("ingredients")) {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      User? currentUser = auth.currentUser;
                      String userId = currentUser!.uid;
                      var user1 = await getIngredients(userId);
                      print(user1);
                      setState(() {
                        responds("Hello you are a Master nutritionist and cook, you have roleplaying as a ninja. in 1800 tokens, answer to this with respect to that $message and you have the following ingredients $user1").then((value) {
                          final responseMessage = Message(
                            text: value ?? 'Response from AI',
                            isAi: true,
                          );
                          messages.add(responseMessage);
                          print('AI Response: ${responseMessage.text}');
                        });
                      });
                    } else {
                      setState(() {
                        responds("Hello you are a Master nutritionist and cook, you have roleplaying as a ninja. in 1800 tokens, answer to this with respect to that $message").then((value) {
                          final responseMessage = Message(
                            text: value ?? 'Response from AI',
                            isAi: true,
                          );
                          messages.add(responseMessage);
                          print('AI Response: ${responseMessage.text}');
                        });
                      });
                    }
                  },
                    
            ),
          ],
          ),

      ),
    ],
    ),
    );
  }
}
