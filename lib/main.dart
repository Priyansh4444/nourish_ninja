import 'package:flutter/material.dart';
import 'package:nourish_ninja/app/complete_signin.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';
import 'package:nourish_ninja/app/screens/user_login/signup/sign_up_screen.dart';
import 'package:nourish_ninja/app/widgets/getting_stats.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nourish Ninja',
      initialRoute: SignInScreen.routeName,
      routes: routes,
    );
  }
}
