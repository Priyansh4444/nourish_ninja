import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  int calories;
  int carbohydrates;
  int dietaryFiber;
  int iodine;
  int magnesium;
  int potassium;
  int protein;
  int sodium;
  int sugar;
  int totalFat;
  int transFat;
  String username;
  int vitaminA;
  int vitaminB12;
  int vitaminB6;
  int vitaminC;
  int vitaminD;
  int vitaminE;
  int vitaminK;
  String? uid;

  UserData({
    this.calories = 0,
    this.carbohydrates = 0,
    this.dietaryFiber = 0,
    this.iodine = 0,
    this.magnesium = 0,
    this.potassium = 0,
    this.protein = 0,
    this.sodium = 0,
    this.sugar = 0,
    this.totalFat = 0,
    this.transFat = 0,
    this.username = "Priyansh",
    this.vitaminA = 0,
    this.vitaminB12 = 0,
    this.vitaminB6 = 0,
    this.vitaminC = 0,
    this.vitaminD = 0,
    this.vitaminE = 0,
    this.vitaminK = 0,
  });

  Future<void> getUser(String uuid) async {
    // Fetch the data of the user's UUID from Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uuid).get();

    // Update the user data based on the fetched data
    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data()!;
      calories = userData['calories'] ?? calories;
      carbohydrates = userData['carbohydrates'] ?? carbohydrates;
      dietaryFiber = userData['dietaryFiber'] ?? dietaryFiber;
      iodine = userData['iodine'] ?? iodine;
      magnesium = userData['magnesium'] ?? magnesium;
      potassium = userData['potassium'] ?? potassium;
      protein = userData['protein'] ?? protein;
      sodium = userData['sodium'] ?? sodium;
      sugar = userData['sugar'] ?? sugar;
      totalFat = userData['totalFat'] ?? totalFat;
      transFat = userData['transFat'] ?? transFat;
      username = userData['username'] ?? username;
      vitaminA = userData['vitaminA'] ?? vitaminA;
      vitaminB12 = userData['vitaminB12'] ?? vitaminB12;
      vitaminB6 = userData['vitaminB6'] ?? vitaminB6;
      vitaminC = userData['vitaminC'] ?? vitaminC;
      vitaminD = userData['vitaminD'] ?? vitaminD;
      vitaminE = userData['vitaminE'] ?? vitaminE;
      vitaminK = userData['vitaminK'] ?? vitaminK;
    }
  }

  Future<void> addUser(String uuid, String json_data) async {
    // Create a map of the user data to be added
    Map<String, dynamic> results = json.decode(json_data)['records'][0];
  print(results);
  // Create a map of the user data to be added
  Map<String, dynamic> userData = {
    'calories': results['calories'] ?? calories,
    'carbohydrates': results['carbohydrates'] ?? carbohydrates,
    'dietaryFiber': results['dietaryFiber'] ?? dietaryFiber,
    'iodine': results['iodine'] ?? iodine,
    'magnesium': results['magnesium'] ?? magnesium,
    'potassium': results['potassium'] ?? potassium,
    'protein': results['protein'] ?? protein,
    'sodium': results['sodium'] ?? sodium,
    'sugar': results['sugar'] ?? sugar,
    'totalFat': results['totalFat'] ?? totalFat,
    'transFat': results['transFat'] ?? transFat,
    'username': results['username'] ?? username,
    'vitaminA': results['vitaminA'] ?? vitaminA,
    'vitaminB12': results['vitaminB12'] ?? vitaminB12,
    'vitaminB6': results['vitaminB6'] ?? vitaminB6,
    'vitaminC': results['vitaminC'] ?? vitaminC,
    'vitaminD': results['vitaminD'] ?? vitaminD,
    'vitaminE': results['vitaminE'] ?? vitaminE,
    'vitaminK': results['vitaminK'] ?? vitaminK,
  };

    // Add the user data to Firestore using the UUID as the index
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .set(userData);
  }

}


