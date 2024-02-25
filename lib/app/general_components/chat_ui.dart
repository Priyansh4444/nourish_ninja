import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';
import 'package:nourish_ninja/app/screens/user_stats/components/calorie_count.dart';
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

  const MessageBubble({super.key, required this.text, required this.isAi});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isAi ? const Color.fromARGB(255, 47, 47, 47) : NourishNinjaTheme.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isAi ? const Color.fromARGB(255, 255, 255, 255) : const Color.fromARGB(255, 0, 0, 0),
          fontSize: 16,
        ),
      ),
    );
  }
}

class ChatUI extends StatefulWidget {
  static String routeName = "/chat";

  const ChatUI({super.key});
  @override
  _ChatUIState createState() => _ChatUIState();
}

class _ChatUIState extends State<ChatUI> {
  List<Message> messages = [
    Message(text: 'Hello! How can I assist you today?', isAi: true),
  ];

  final TextEditingController _textEditingController =
      TextEditingController(); // Add a TextEditingController

  @override
  Widget build(BuildContext context) {
    var message = ''; // Declare the 'message' variable

    print('Building ChatUI'); // Replace with a logging framework

    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Chatbot', style: TextStyle(color: Colors.white),), 
            backgroundColor: NourishNinjaTheme.darkText, // Add 'const' keyword for improved performance
            iconTheme: const IconThemeData(color: Colors.white), // Set the icon color to white
      ),
      backgroundColor: NourishNinjaTheme.background,
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
                    controller: _textEditingController,
                    style:const TextStyle(color: Colors.white), // Add the style property to change the input text color
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(),
                      hintStyle: TextStyle(color: Colors.grey),
                      // Add the style property to change the input text color
                      // You can replace Colors.black with your desired color
                      // For example, Colors.blue, Colors.red, etc.
                      
                    ),
                    
                    onChanged: (text) {
                      setState(() {
                        print('Message changed: $text');
                        message = text ?? '';
                        print(message);
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    setState(() async {
                      final newMessage = Message(
                          text: _textEditingController.text, isAi: false);
                      messages.add(newMessage);
                      message = _textEditingController.text;
                      _textEditingController.clear();
                      print('User Message: $message');

                      String responseText =
                          "Hello you are a Master nutritionist and cook, you have roleplaying as a ninja. in 1800 tokens, answer to this with respect to that $message";
                      if (message.contains("ingredients")) {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        User? currentUser = auth.currentUser;
                        String userId = currentUser!.uid;
                        var user1 = await getIngredients(userId);
                        print(user1);
                        responseText +=
                            " and you have the following ingredients $user1";
                      }
                      FirebaseAuth auth = FirebaseAuth.instance;
                      User? currentUser = auth.currentUser;
                      String userId = currentUser!.uid;
                      var user1 = await getUserGoals(userId);
                      var user2 = await getUser(userId);
                      print(user1);
                      responseText +=
                          " and this is the current user status: the user has the following goals $user1 and you have the following nutrients $user2. focus more only the macro nutrients and also pay less attention to the other ingredients Give me a specific answer to his intended question just while keeping these things in mind! also remember you are a nutritionist, dont overwhlem the user either ";
                      responds(responseText).then((value) {
                        final responseMessage = Message(
                          text: value ?? 'Response from AI',
                          isAi: true,
                        );
                        messages.add(responseMessage);
                        print('AI Response: ${responseMessage.text}');
                      });
                    });
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
