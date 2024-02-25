import 'package:flutter/material.dart';
import 'package:nourish_ninja/app/general_components/chat_ui.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';
import 'package:nourish_ninja/app/scanner/google_ml_kit.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';
import 'package:nourish_ninja/app/screens/user_login/signup/sign_up_screen.dart';
import 'package:nourish_ninja/app/screens/user_stats/components/google_fit.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';
import 'package:nourish_ninja/app/widgets/getting_stats.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => const SignInScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ChatUI.routeName: (context) => const ChatUI(),
  GettingStats.routeName: (context) => GettingStats(),
  Stats.routeName: (context) => const Stats(),
  Tracker.routeName: (context) => const Tracking(),
  TextRecognizerView.routeName: (context) => const TextRecognizerView(),
};





class Tracking extends StatefulWidget {
  const Tracking({super.key});

  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<Tracking>
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

