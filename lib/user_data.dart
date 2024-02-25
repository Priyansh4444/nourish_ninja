import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserData {
  String calories;
  int carbohydrates;
  String dietaryFiber;
  String iodine;
  String magnesium;
  String potassium;
  String protein;
  String sodium;
  String sugar;
  String totalFat;
  String transFat;
  String username;
  String vitaminA;
  String vitaminB12;
  String vitaminB6;
  String vitaminC;
  String vitaminD;
  String vitaminE;
  String vitaminK;
  String? uid;
  String? foodItems;

  UserData({
    this.calories = "0",
    this.carbohydrates = 0,
    this.dietaryFiber = "0",
    this.iodine = "0",
    this.magnesium = "0",
    this.potassium = "0",
    this.protein = "0",
    this.sodium = "0",
    this.sugar = "0",
    this.totalFat = "0",
    this.transFat = "0",
    this.username = "Priyansh",
    this.vitaminA = "0",
    this.vitaminB12 = "0",
    this.vitaminB6 = "0",
    this.vitaminC = "0",
    this.vitaminD = "0",
    this.vitaminE = "0",
    this.vitaminK = "0",
    this.foodItems = "",
  });

  Future<void> addUser(String uuid, String jsonData) async {
    // Create a map of the user data to be added
    Map<String, dynamic> results = json.decode(jsonData)['records'][0];
    print("calories: ${results['energy']}");
    // Create a map of the user data to be added
    Map<String, dynamic> userData = {
      'calories': results['energy']['kilocalories'] ?? calories,
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
        .set(userData, SetOptions(merge: true));
  }
}

class UserGoals {
  String? protein;
  String? carbohydrates;
  String? fat;
  String? fiber;
  String? calcium;
  String? iron;
  String? vitaminA;
  String? vitaminC;
  String? vitaminD;
  String? vitaminE;
  String? vitaminK;
  String? thiamin;
  String? riboflavin;
  String? niacin;
  String? vitaminB6;
  String? folate;
  String? vitaminB12;
  String? pantothenicAcid;
  String? biotin;
  String? choline;
  String? selenium;
  String? zinc;
  String? copper;
  String? manganese;
  String? chromium;
  String? molybdenum;
  String? iodine;
  String? potassium;
  String? magnesium;
  String? phosphorus;
  String? sodium;

  UserGoals({
    this.protein,
    this.carbohydrates,
    this.fat,
    this.fiber,
    this.calcium,
    this.iron,
    this.vitaminA,
    this.vitaminC,
    this.vitaminD,
    this.vitaminE,
    this.vitaminK,
    this.thiamin,
    this.riboflavin,
    this.niacin,
    this.vitaminB6,
    this.folate,
    this.vitaminB12,
    this.pantothenicAcid,
    this.biotin,
    this.choline,
    this.selenium,
    this.zinc,
    this.copper,
    this.manganese,
    this.chromium,
    this.molybdenum,
    this.iodine,
    this.potassium,
    this.magnesium,
    this.phosphorus,
    this.sodium,
  });
}

Future<void> addGoals(String uuid, Map<String, dynamic> jsonData) async {
  await FirebaseFirestore.instance
      .collection('user_goals')
      .doc(uuid)
      .set(jsonData, SetOptions(merge: true));
  print("successful");
}

class UserIngredients {
  String? ingredients;

  UserIngredients({this.ingredients});

  Future<void> addIngredients(String uuid, String jsonData) async {
    // Create a map of the user data to be added

    // Create a map of the user data to be added
    // Create a map of the user data to be added
    Map<String, dynamic> userData = {
      'ingredients': jsonData,
    };

    // Add the user data to Firestore using the UUID as the index
    await FirebaseFirestore.instance
        .collection('user_ingredients')
        .doc(uuid)
        .set(userData);
  }
}

Future<String> getIngredients(String uuid) async {
  // Fetch the data of the user's UUID from Firestore
  DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
      .instance
      .collection('user_ingredients')
      .doc(uuid)
      .get();

  print(snapshot.data().runtimeType);
  Map<String, dynamic> userData = snapshot.data()!;
  print(userData);
  var ingredients = userData['ingredients']?.toString() ?? "";

  // Update the user data based on the fetched data
  return ingredients;
}
