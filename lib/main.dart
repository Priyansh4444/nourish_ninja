
import 'package:flutter/material.dart';
import 'package:nourish_ninja/app/complete_signin.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';

import 'package:camera/camera.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final cameras = await availableCameras();
//   final firstCamera = cameras.first;

//   runApp(MyApp(firstCamera));
// }

// class MyApp extends StatelessWidget {
//   final CameraDescription camera;

//   MyApp(this.camera);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData.dark(),
//       home: TakePictureScreen(camera: camera),
//     );
//   }
// }


void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nourish Ninja',
//       home: Stat                                                                     s(),
//     );
//   }
// }


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nourish Ninja',
      initialRoute: Tracker.routeName,
      routes: routes,
    );
  }
}







// class MyApp extends StatefulWidget {
//   @override
//   _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
// }

// class _FitnessAppHomeScreenState extends State<MyApp>
//     with TickerProviderStateMixin {
//   AnimationController? animationController;


//   Widget tabBody = Container(
//     color: NourishNinjaTheme.background,
//   );

//   @override
//   void initState() {
//     animationController = AnimationController(
//         duration: const Duration(milliseconds: 600), vsync: this);
//     tabBody = Tracker(animationController: animationController);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Nourish Ninja',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
      
//       home: Tracker(animationController: animationController),

//     );
//   }
// }

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
