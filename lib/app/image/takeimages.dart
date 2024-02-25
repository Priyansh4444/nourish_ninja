import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nourish_ninja/app/image/image_to_spoonacular.dart';

class TakeImagesScreen extends StatefulWidget {
  static String routeName = "/take_images";
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
        title: Text('Take Images'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Select Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: _takeImage,
              child: Text('Take Image'),
            ),
            SizedBox(height: 16),
            if (_image != null)
              Image.file(
                _image!,
                height: 200,
              ),
            SizedBox(height: 16),
            if (_text != null)
              Text(
                _text!,
                style: TextStyle(fontSize: 18),
              ),
          ],
        ),
      ),
    );
  }
}
