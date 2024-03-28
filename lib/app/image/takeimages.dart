import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';
import 'package:nourish_ninja/app/image/image_to_spoonacular.dart';

class TakeImagesScreen extends StatefulWidget {
  static String routeName = "/take_images";

  const TakeImagesScreen({super.key});
  @override
  _TakeImagesScreenState createState() => _TakeImagesScreenState();
}

class _TakeImagesScreenState extends State<TakeImagesScreen> {
  File? _image;
  String? _text;

  final picker = ImagePicker();

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      _processImage();
    }
  }

  Future<void> _takeImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });

      _processImage();
    }
  }

  Future<void> _processImage() async {
    // Call your function to process the image and retrieve the text
    // Replace the code below with your own implementation
    final imgJson = await uploadImage(_image!);
    setState(() {
      _text = 'Sample Text';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Take Images', style: TextStyle(color: Colors.white)),
        backgroundColor: NourishNinjaTheme.darkText,
      ),
      backgroundColor: NourishNinjaTheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getImageFromGallery,
              style: ElevatedButton.styleFrom(
                backgroundColor: NourishNinjaTheme.darkText,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(13),
                    bottomLeft: Radius.circular(13),
                  ),
                ),
              ),
              child: const Text('Select Image from Gallery',
                  style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _takeImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: NourishNinjaTheme.darkText,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(13),
                    bottomLeft: Radius.circular(13),
                  ),
                ),
              ),
              child: const Text(
                'Take Image',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
              ),
            const SizedBox(height: 16),
            if (_text != null)
              Text(
                _text!,
                style: const TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
