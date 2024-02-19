import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<void> main() async {
  // Access your API key as an environment variable (see "Set up your API key" above)
  await dotenv.load(fileName: '.env');
  final apiKey = dotenv.env['API_KEY'];
  if (apiKey == null) {
    print('No \$API_KEY environment variable');
  }
  // For text-only input, use the gemini-pro model
  final model = GenerativeModel(
      model: 'gemini-pro',
      apiKey: apiKey!,
      generationConfig: GenerationConfig(maxOutputTokens: 100));
  // Initialize the chat
  final chat = model.startChat(history: [
    Content.text('Hello, I have 2 dogs in my house.'),
    Content.model([TextPart('Great to meet you. What would you like to know?')])
  ]);
  var content = Content.text('How many paws are in my house?');
  var response = await chat.sendMessage(content);
  print(response.text);
}
