import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String calories;
  String carbohydrates;
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
  String weight;
  String height;
  String age;
  String? foodItems;

  UserData({
    this.calories = "300",
    this.carbohydrates = "0",
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
    this.weight = "53.0",
    this.height = "1.75",
    this.age = "20",
    this.foodItems = "",
  });

  Future<String> getUser(String uuid) async {
    // Fetch the data of the user's UUID from Firestore
    DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .doc(uuid)
        .get();

    print(snapshot.data().runtimeType);
    Map<String, dynamic> userData = snapshot.data()!;
    print(userData);
    calories = (userData['calories'] ?? calories).toString();
    carbohydrates = (userData['carbohydrates'] ?? carbohydrates).toString();
    dietaryFiber = userData['dietaryFiber']?.toString() ?? dietaryFiber;
    iodine = userData['iodine']?.toString() ?? iodine;
    magnesium = userData['magnesium']?.toString() ?? magnesium;
    potassium = userData['potassium']?.toString() ?? potassium;
    protein = userData['protein']?.toString() ?? protein;
    sodium = userData['sodium']?.toString() ?? sodium;
    sugar = userData['sugar']?.toString() ?? sugar;
    totalFat = userData['totalFat']?.toString() ?? totalFat;
    transFat = userData['transFat']?.toString() ?? transFat;
    username = userData['username']?.toString() ?? username;
    vitaminA = userData['vitaminA']?.toString() ?? vitaminA;
    vitaminB12 = userData['vitaminB12']?.toString() ?? vitaminB12;
    vitaminB6 = userData['vitaminB6']?.toString() ?? vitaminB6;
    vitaminC = userData['vitaminC']?.toString() ?? vitaminC;
    vitaminD = userData['vitaminD']?.toString() ?? vitaminD;
    vitaminE = userData['vitaminE']?.toString() ?? vitaminE;
    vitaminK = userData['vitaminK']?.toString() ?? vitaminK;
    height = userData['height']?.toString() ?? height;
    weight = userData['weight']?.toString() ?? weight;
    age = userData['age']?.toString() ?? age;
    foodItems = userData['foodItems']?.toString() ?? foodItems;

    // Update the user data based on the fetched data
    return "Calories: $calories, Carbohydrates: $carbohydrates, Dietary Fiber: $dietaryFiber, Iodine: $iodine, Magnesium: $magnesium, Potassium: $potassium, Protein: $protein, Sodium: $sodium, Sugar: $sugar, Total Fat: $totalFat";
  }

  Future<void> addUser(String uuid, String jsonData) async {
    // Create a map of the user data to be added
    Map<String, dynamic> results = json.decode(jsonData)['records'][0];
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
      'height': results['height'] ?? height,
      'age': results['age'] ?? age,
      'weight': results['weight'] ?? weight,
    };

    // Add the user data to Firestore using the UUID as the index
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uuid)
        .set(userData);
  }
}

Future makeGetRequest() async {
  print("im here");
  final params = {
    'measurement_units': 'met',
    'sex': 'male', // Ensure required parameter is present
    'age_value': '20', // Ensure required parameter is present
    'age_type': 'yrs', // Ensure required parameter is present
    'cm': '175',
    'kilos': '60',
    'activity_level': 'Active'
  };
  final response = await http.get(
    Uri.parse(
        "https://nutrition-calculator.p.rapidapi.com/api/nutrition-info?measurement_units=met&sex=male&age_value=20&age_type=yrs&cm=175&kilos=60&activity_level=Active"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'X-RapidAPI-Key': '7bdd0a2ac9msh32e0f02f3e00b93p11a33bjsnbae7af1bae20',
      'X-RapidAPI-Host': 'nutrition-calculator.p.rapidapi.com'
    },
  );
  print(response.statusCode);
  var data = jsonDecode(response.body);
  if (response.statusCode == 200) {
    if (kDebugMode) {
      print(data);
    }
  } else {
    if (kDebugMode) {
      print(response.statusCode);
    }
  }
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
