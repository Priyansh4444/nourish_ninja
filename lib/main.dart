
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nourish_ninja/app/complete_signin.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';
import 'package:nourish_ninja/app/screens/user_login/signup/sign_up_screen.dart';
import 'package:nourish_ninja/app/screens/user_stats/components/google_fit.dart';
import 'package:nourish_ninja/app/scanner/google_ml_kit.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';

import './image_scanning.dart';

import 'package:camera/camera.dart';

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
      initialRoute: SignUpScreen.routeName,
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

