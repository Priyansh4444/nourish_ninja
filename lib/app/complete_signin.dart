import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';
import 'package:nourish_ninja/app/screens/user_login/signup/sign_up_screen.dart';
import 'package:nourish_ninja/app/screens/user_login/signup/sign_in.dart';
import 'package:nourish_ninja/app/screens/user_stats/components/google_fit.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';

final Map<String, WidgetBuilder> routes = {
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),

  Stats.routeName: (context) => Stats(),
  Tracker.routeName: (context) => Tracking(),
  
};





class Tracking extends StatefulWidget {
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

