import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

void addNutritionToHealthConnect(name, protein, carbs, fat, calories) async {
  // Check if Google Health Connect is available
  FirebaseAuth auth = FirebaseAuth.instance;
  String uuid = auth.currentUser!.uid;

  DocumentSnapshot<Map<String, dynamic>> snapshot =
      await FirebaseFirestore.instance.collection('users').doc(uuid).get();
  Map<String, dynamic> userData = snapshot.data()!;
  userData['calories'] += calories;
  userData['carbohydrates'] += carbs;
  userData['protein']["grams"] += protein;
  userData['totalFat']["grams"] += fat;
  userData['foodItems'] = name;
  await FirebaseFirestore.instance
      .collection('users')
      .doc(uuid)
      .update(userData);
}
