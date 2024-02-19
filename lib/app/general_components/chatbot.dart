import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_generative_ai/google_generative_ai.dart';


Future<Map<String, String>> parseStringToMap({String assetsFileName = '.env'}) async {
  final lines = await rootBundle.loadString(assetsFileName);
  Map<String, String> environment = {};
  for (String line in lines.split('\n')) {
    line = line.trim();
    if (line.contains('=') //Set Key Value Pairs on lines separated by =
        &&
        !line.startsWith(RegExp(r'=|#'))) {
      //No need to add emty keys and remove comments
      List<String> contents = line.split('=');
      environment[contents[0]] = contents.sublist(1).join('=');
    }
  }
  return environment;
}
<<<<<<< HEAD
Future<void> main() async {
  // Access your API key as an environment variable (see "Set up your API key" above)
  final apiKey = Platform.environment['API_KEY'];
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
=======



// Future<void> main() async {
//   // Access your API key as an environment variable (see "Set up your API key" above)
//   final apiKey = Platform.environment['API_KEY'];
//   if (apiKey == null) {
//     print('No \$API_KEY environment variable');
//   }
//   // For text-only input, use the gemini-pro model
//   final model = GenerativeModel(
//       model: 'gemini-pro',
//       apiKey: apiKey!,
//       generationConfig: GenerationConfig(maxOutputTokens: 100));
//   // Initialize the chat
//   final chat = model.startChat(history: [
//     Content.text('Hello, I have 2 dogs in my house.'),
//     Content.model([TextPart('Great to meet you. What would you like to know?')])
//   ]);
//   var content = Content.text('How many paws are in my house?');
//   var response = await chat.sendMessage(content);
//   print(response.text);
// }
>>>>>>> 0c9cc78fe756fac836a9674335ff18ec5015756f
