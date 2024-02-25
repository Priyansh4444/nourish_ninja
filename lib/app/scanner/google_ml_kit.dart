import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:nourish_ninja/user_data.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'detector_view.dart';

class TextRecognizerView extends StatefulWidget {
  static String routeName = "/text_recognizer";

  const TextRecognizerView({super.key});
  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  var _script = TextRecognitionScript.latin;
  var _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  CustomPaint? _customPaint;
  String? _text;
  var _cameraLensDirection = CameraLensDirection.back;

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        DetectorView(
          title: 'Text Detector',
          customPaint: _customPaint,
          text: _text,
          onImage: _processImage,
          initialCameraLensDirection: _cameraLensDirection,
          onCameraLensDirectionChanged: (value) => _cameraLensDirection = value,
        ),
        Positioned(
            top: 30,
            left: 100,
            right: 100,
            child: Row(
              children: [
                const Spacer(),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: _buildDropdown(),
                    )),
                const Spacer(),
              ],
            )),
      ]),
    );
  }

  Widget _buildDropdown() => DropdownButton<TextRecognitionScript>(
        value: _script,
        icon: const Icon(Icons.arrow_downward),
        elevation: 16,
        style: const TextStyle(color: Colors.blue),
        underline: Container(
          height: 2,
          color: Colors.blue,
        ),
        onChanged: (TextRecognitionScript? script) {
          if (script != null) {
            setState(() {
              _script = script;
              _textRecognizer.close();
              _textRecognizer = TextRecognizer(script: _script);
            });
          }
        },
        items: TextRecognitionScript.values
            .map<DropdownMenuItem<TextRecognitionScript>>((script) {
          return DropdownMenuItem<TextRecognitionScript>(
            value: script,
            child: Text(script.name),
          );
        }).toList(),
      );

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;
    setState(() {
      _text = '';
    });
    final recognizedText = await _textRecognizer.processImage(inputImage);
    if (inputImage.metadata?.size != null &&
        inputImage.metadata?.rotation != null) {

      
    } else {
      await dotenv.load();
    final apiKey = dotenv.env['API_KEY'];

      if (apiKey == null) {
        print('No \$API_KEY environment variable');
      }
      // For text-only input, use the gemini-pro model
      final model = GenerativeModel(
          model: 'gemini-pro',
          apiKey: apiKey!,
          generationConfig: GenerationConfig(maxOutputTokens: 1800));
      // Initialize the chat
      final chat = model.startChat(history: [
        Content.text(
            'Make the following recognized text into a text of ingredients and return it as ONLY A JSON TO ME in AND DONT PUT ANYTHING YOU ARE NOT SURE OF, also remove the ```json and stuff and make it perfectly parsable as a normal text 1800 tokens:'),
        Content.model([
          TextPart('Ok I will do so!')
        ]),
      ]);
      print(recognizedText.text);
      var content = Content.text(recognizedText.text);
      var response = await chat.sendMessage(content);
      print(response.text);
     
      _text = 'Added to database $response';
                FirebaseAuth auth = FirebaseAuth.instance;
                User? currentUser = auth.currentUser;
                String userId = currentUser!.uid;
                var user1 = UserIngredients();
                user1.addIngredients(userId, response.text!);
      
      _customPaint = null;
      
    }
    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
