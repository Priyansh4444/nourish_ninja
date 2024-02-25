import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future uploadImage(File imageFile) async {
  var stream = http.ByteStream(imageFile.openRead());
  stream.cast();
  var length = await imageFile.length();
  await dotenv.load(fileName: ".env");
  final apiKey = dotenv.env['SPOONACULAR'];
  var uri = Uri.parse(
      "https://api.spoonacular.com/food/images/analyze?apiKey=${apiKey}&includeNutrition=true");
  var request = http.MultipartRequest("POST", uri);
  var multipartFile = http.MultipartFile("file", stream, length,
      filename: basename(imageFile.path));
  request.files.add(multipartFile);
  var response = await request.send();
  if (response.statusCode == 200) {
    print("Image Uploaded");
    var responseBody = await http.Response.fromStream(response);
    var rB = jsonDecode(responseBody.body);
    print(rB);
  } else {
    print(response.statusCode);
  }
}