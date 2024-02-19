// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:nourish_ninja/app/screens/forgot_password/forgot.dart';
import 'package:nourish_ninja/app/screens/home_screen/home.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login.dart';
import 'package:nourish_ninja/app/screens/user_login/successScreen/success_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nourish Ninja',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), // Set the sign-in page as the home page
    );
  }
}

