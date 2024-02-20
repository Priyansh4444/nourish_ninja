
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:nourish_ninja/app/complete_signin.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';
import 'package:nourish_ninja/app/screens/user_login/signin/login_page.dart';
import 'package:nourish_ninja/app/screens/user_login/signup/sign_up_screen.dart';
import 'package:nourish_ninja/app/screens/user_stats/components/google_fit.dart';
import 'package:nourish_ninja/app/scanner/google_ml_kit.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';

import 'package:camera/camera.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  static const String routeName = '/gemini_querying';
  
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _startChat() async {
    await dotenv.load();
    final apiKey = dotenv.env['API_KEY'];
    if (apiKey == null) {
      debugPrint('No \$API_KEY environment variable');
      exit(1);
    }

    
    final model = GenerativeModel(
        model: 'gemini-pro',
        apiKey: apiKey,
        generationConfig: GenerationConfig(maxOutputTokens: 5000));
    final chat = model.startChat(history: [
      Content.text('Act Like A Nutritionist, Consult multiple sources, and talk about what ingredients i should but from the store today using these nutritions about mecoupled with some beautiful recipes, by taking into consider everything from my age to calories my height, and wieght, also tell me my health status in 4000 tokens'),
      Content.model([TextPart('Great to meet you. I am the perfect nutritionist and I can help you with your diet')])
    ]);
    var content = Content.text('?');
    var response = await chat.sendMessage(content);
    debugPrint(response.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nourish Ninja'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _startChat,
          child: const Text('Start Chat'),
        ),
      ),
    );
  }
}
