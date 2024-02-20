import 'dart:convert';
import 'dart:ffi';
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
  });

  Future<String> getUser(String uuid) async {
   // Fetch the data of the user's UUID from Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('users').doc('0zjldbIupRTSsAzLpRpClMjs1lL2').get();

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
      // Update the user data based on the fetched data
      return "Calories: $calories, Carbohydrates: $carbohydrates, Dietary Fiber: $dietaryFiber, Iodine: $iodine, Magnesium: $magnesium, Potassium: $potassium, Protein: $protein, Sodium: $sodium, Sugar: $sugar, Total Fat: $totalFat";
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

Future<String> makeGetRequest() async {
  // const url = 'https://nutrition-calculator.p.rapidapi.com/api/nutrition-info';
  // const apiKey = '7bdd0a2ac9msh32e0f02f3e00b93p11a33bjsnbae7af1bae20'; // Replace with your actual API key

  // final params = {
  //   'measurement_units': 'metr',
  //   'sex': 'male', // Ensure required parameter is present
  //   'age_value': '20', // Ensure required parameter is present
  //   'age_type': 'yrs', // Ensure required parameter is present
  //   'cm': '175',
  //   'kilos': '60',
  //   'activity_level': 'Active'
  // };

  // final headers = {
  //   'X-RapidAPI-Key': apiKey,
  //   'X-RapidAPI-Host': 'nutrition-calculator.p.rapidapi.com'
  // };
  // final response = await http.get(
  //   Uri.parse(url).replace(queryParameters: params),
  //   headers: headers,
  // );

  // if (response.statusCode == 200) {
  //   // Process the JSON data here
  //   print(response.body);
  // } else {
  //   print('Error: ${response.statusCode} - ${response.body}');
  
  // }

  // TODO: Implement the API call to the nutrition calculator API

  final json12 = {
  "BMI_EER": {
    "BMI": "21.9",
    "Estimated Daily Caloric Needs": "2,315 kcal/day"
  },
  "macronutrients_table": {
    "macronutrients-table": [
      [
        "Macronutrient",
        "Recommended Intake Per Day"
      ],
      [
        "Carbohydrate",
        "260 - 376 grams"
      ],
      [
        "Total Fiber",
        "25 grams"
      ],
      [
        "Protein",
        "44 grams"
      ],
      [
        "Fat",
        "51 - 90 grams"
      ],
      [
        "Saturated fatty acids",
        "As low as possible while consuming a nutritionally adequate diet."
      ],
      [
        "Transfatty acids",
        "As low as possible while consuming a nutritionally adequate diet."
      ],
      [
        "α-Linolenic Acid",
        "1.1 grams"
      ],
      [
        "Linoleic Acid",
        "12 grams"
      ],
      [
        "Dietary Cholesterol",
        "As low as possible while consuming a nutritionally adequate diet."
      ],
      [
        "Total Water",
        "2.7 liters  (about 11 cups)"
      ]
    ]
  },
  "minerals_table": {
    "minerals-table": [
      [
        "Mineral",
        "Recommended Intake Per Day",
        "Tolerable UL Intake Per Day"
      ],
      [
        "Essential"
      ],
      [
        "Calcium",
        "1,000 mg",
        "2,500 mg"
      ],
      [
        "Chloride",
        "2.3 g",
        "3.6 g"
      ],
      [
        "Chromium",
        "25 mcg",
        "0 mcg"
      ],
      [
        "Copper",
        "900 mcg",
        "10,000 mcg"
      ],
      [
        "Fluoride",
        "3 mg",
        "10 mg"
      ],
      [
        "Iodine",
        "150 mcg",
        "1,100 mcg"
      ],
      [
        "Iron",
        "18 mg",
        "45 mg"
      ],
      [
        "Magnesium",
        "310 mg",
        "350 mg"
      ],
      [
        "Manganese",
        "1.8 mg",
        "11 mg"
      ],
      [
        "Molybdenum",
        "45 mcg",
        "2,000 mcg"
      ],
      [
        "Phosphorus",
        "0.7 g",
        "4 g"
      ],
      [
        "Potassium",
        "2,600 mg",
        "0 mg"
      ],
      [
        "Selenium",
        "55 mcg",
        "400 mcg"
      ],
      [
        "Sodium",
        "1,500 mg",
        "0 mg"
      ],
      [
        "Zinc",
        "8 mg",
        "40 mg"
      ],
      [
        "Non-Essential"
      ],
      [
        "Arsenic",
        "NA",
        "ND"
      ],
      [
        "Boron",
        "0 mg",
        "20 mg"
      ],
      [
        "Nickel",
        "0 mg",
        "1 mg"
      ],
      [
        "Silicon",
        "NA",
        "ND"
      ],
      [
        "Sulfate",
        "NA",
        "ND"
      ],
      [
        "Vanadium",
        "0 mg",
        "1.8 mg"
      ]
    ]
  },
  "vitamins_table": {
    "vitamins-table": [
      [
        "Vitamin",
        "Recommended Intake Per Day",
        "Tolerable UL Intake Per Day"
      ],
      [
        "Vitamin A",
        "700 mcg",
        "3,000 mcg"
      ],
      [
        "Vitamin C",
        "75 mg",
        "2,000 mg"
      ],
      [
        "Vitamin D",
        "15 mcg",
        "100 mcg"
      ],
      [
        "Vitamin B6",
        "1.3 mg",
        "100 mg"
      ],
      [
        "Vitamin E",
        "15 mg",
        "1,000 mg"
      ],
      [
        "Vitamin K",
        "90 mcg",
        "0 mcg"
      ],
      [
        "Thiamin",
        "1.1 mg",
        "0 mg"
      ],
      [
        "Vitamin B12",
        "2.4 mcg",
        "0 mcg"
      ],
      [
        "Riboflavin",
        "1.1 mg",
        "0 mg"
      ],
      [
        "Folate",
        "400 mcg",
        "1,000 mcg"
      ],
      [
        "Niacin",
        "14 mg",
        "20 mg"
      ],
      [
        "Choline",
        "0.425 g",
        "3.5 g"
      ],
      [
        "Pantothenic Acid",
        "5 mg",
        "0 mg"
      ],
      [
        "Biotin",
        "30 mcg",
        "0 mcg"
      ],
      [
        "Carotenoids",
        "NA",
        "ND"
      ]
    ]
  }
};
return json.encode(json12);
}