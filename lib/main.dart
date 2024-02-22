import 'package:flutter/material.dart';
import 'package:nourish_ninja/app/complete_signin.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';
import 'package:nourish_ninja/app/screens/user_login/signup/sign_up_screen.dart';
import 'package:nourish_ninja/user_data.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';

void main() {
  runApp(MyApp());
}

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
