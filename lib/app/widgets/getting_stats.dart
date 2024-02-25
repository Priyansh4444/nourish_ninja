import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nourish_ninja/app/general_components/ninja_themes.dart';
import 'package:nourish_ninja/app/screens/user_stats/components/google_fit.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';
import 'package:nourish_ninja/app/utils/DRI.dart';
import 'package:nourish_ninja/user_data.dart';

class GettingStats extends StatefulWidget {
  static String routeName = "/getting_stats";
  @override
  _GettingStatsState createState() => _GettingStatsState();
}

class _GettingStatsState extends State<GettingStats> {
  int? age;
  double? weight;
  double? height;
  String? gender;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Getting Stats',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: NourishNinjaTheme.background,
      ),
      body: Container(
        color: NourishNinjaTheme.background,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(
                      20), // Change the bottom right radius to 20
                  bottomRight: Radius.circular(20),
                ),
                child: Container(
                  color: NourishNinjaTheme.nearlyBlue,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(labelText: 'Age'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              age = int.tryParse(value);
                            });
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Weight (kg)'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              weight = double.tryParse(value);
                            });
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(labelText: 'Height (cm)'),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              height = double.tryParse(value);
                            });
                          },
                        ),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(labelText: 'Gender'),
                          value: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value;
                            });
                          },
                          items: [
                            DropdownMenuItem(
                              value: 'Male',
                              child: Text('Male'),
                            ),
                            DropdownMenuItem(
                              value: 'Female',
                              child: Text('Female'),
                            ),
                          ],
                        ),
                        if (errorText != null)
                          Text(
                            errorText!,
                            style: TextStyle(color: Colors.red),
                          ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            if (age == null ||
                                weight == null ||
                                height == null ||
                                gender == null) {
                              setState(() {
                                errorText = 'Please fill in all fields';
                              });
                            } else {
                              // Do something with the user's stats
                              print('Age: $age');
                              print('Weight: $weight');
                              print('Height: $height');
                              print('Gender: $gender');
                              final bmr =
                                  calculateBMR(weight!, height!, age!, gender!);
                              final dailyCalorieNeeds =
                                  calculateDailyCalorieNeeds(
                                      bmr, 'very active');
                              final nutrientRecommendations =
                                  calculateNutrientRecommendations(
                                      dailyCalorieNeeds, gender!, age!);
                              print(nutrientRecommendations);
                              FirebaseAuth auth = FirebaseAuth.instance;
                              User? currentUser = auth.currentUser;
                              String userId = currentUser!.uid;
                              addGoals(userId, nutrientRecommendations);
                              Navigator.pushNamed(context, Tracker.routeName);
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
