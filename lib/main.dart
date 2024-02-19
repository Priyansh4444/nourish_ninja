
import 'package:flutter/material.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<MyApp>
    with TickerProviderStateMixin {
  AnimationController? animationController;


  Widget tabBody = Container(
    color: NourishNinjaTheme.background,
  );

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = Tracker(animationController: animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nourish Ninja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      
      home: Tracker(animationController: animationController),

    );
  }
}

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   Future<void> _startChat() async {
//     await dotenv.load();
//     final apiKey = dotenv.env['API_KEY'];
//     if (apiKey == null) {
//       debugPrint('No \$API_KEY environment variable');
//       exit(1);
//     }
//     final model = GenerativeModel(
//         model: 'gemini-pro',
//         apiKey: apiKey,
//         generationConfig: GenerationConfig(maxOutputTokens: 100));
//     final chat = model.startChat(history: [
//       Content.text('Hello, I have 100 dogs in my house.'),
//       Content.model([TextPart('Great to meet you. What would you like to know?')])
//     ]);
//     var content = Content.text('How many paws are in my house?');
//     var response = await chat.sendMessage(content);
//     debugPrint(response.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Nourish Ninja'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _startChat,
//           child: const Text('Start Chat'),
//         ),
//       ),
//     );
//   }
// }
