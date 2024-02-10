import 'package:flutter/material.dart';

void main() {

  runApp( MyApp() );

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
          backgroundColor: Colors.redAccent,
        ),
        body: Container(
          child: const Text('This is my default text!'),
          backgroundColor: Colors.blueAccent,
          ),
      )
    );
  }
}