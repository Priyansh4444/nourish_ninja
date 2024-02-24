import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nourish_ninja/app/constants.dart';
import 'package:nourish_ninja/app/screens/user_stats/user_stats.dart';
import 'package:nourish_ninja/user_data.dart';

class Stats extends StatefulWidget {
  const Stats({super.key});

  static String routeName = "/stats";

  @override
  State<Stats> createState() => _MyAppState();
}

class _MyAppState extends State<Stats> {
  // List<HealthConnectDataType> types = [
  //   HealthConnectDataType.ActiveCaloriesBurned,
  //   HealthConnectDataType.BasalBodyTemperature,
  //   HealthConnectDataType.BasalMetabolicRate,
  //   HealthConnectDataType.BloodGlucose,
  //   HealthConnectDataType.BloodPressure,
  //   HealthConnectDataType.BodyFat,
  //   HealthConnectDataType.BodyTemperature,
  //   HealthConnectDataType.BoneMass,
  //   HealthConnectDataType.CervicalMucus,
  //   HealthConnectDataType.CyclingPedalingCadence,
  //   HealthConnectDataType.Distance,
  //   HealthConnectDataType.ElevationGained,
  //   HealthConnectDataType.ExerciseEvent,
  //   HealthConnectDataType.ExerciseLap,
  //   HealthConnectDataType.ExerciseRepetitions,
  //   HealthConnectDataType.ExerciseSession,
  //   HealthConnectDataType.FloorsClimbed,
  //   HealthConnectDataType.HeartRate,
  //   HealthConnectDataType.Height,
  //   HealthConnectDataType.HipCircumference,
  //   HealthConnectDataType.Hydration,
  //   HealthConnectDataType.LeanBodyMass,
  //   HealthConnectDataType.MenstruationFlow,
  //   HealthConnectDataType.Nutrition,
  //   HealthConnectDataType.OvulationTest,
  //   HealthConnectDataType.OxygenSaturation,
  //   HealthConnectDataType.Power,
  //   HealthConnectDataType.RespiratoryRate,
  //   HealthConnectDataType.RestingHeartRate,
  //   HealthConnectDataType.SexualActivity,
  //   HealthConnectDataType.SleepSession,
  //   HealthConnectDataType.SleepStage,
  //   HealthConnectDataType.Speed,
  //   HealthConnectDataType.StepsCadence,
  //   HealthConnectDataType.Steps,
  //   HealthConnectDataType.SwimmingStrokes,
  //   HealthConnectDataType.TotalCaloriesBurned,
  //   HealthConnectDataType.Vo2Max,
  //   HealthConnectDataType.WaistCircumference,
  //   HealthConnectDataType.Weight,
  //   HealthConnectDataType.WheelchairPushes,
  // ];

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Weight,
    HealthConnectDataType.Height,
    HealthConnectDataType.Nutrition,
  ];

// Get the current user credentials in Firebase being used by the app

  bool readOnly = false;
  String resultText = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(Constants.userUUID),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(
              onPressed: () async {
                await HealthConnectFactory.installHealthConnect();
              },
              child: const Text('Install Health Connect'),
            ),         
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.requestPermissions(
                  types,
                  readOnly: readOnly,
                );
                resultText = 'requestPermissions: $result';
              },
              child: const Text('Request Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime =
                    DateTime.now().subtract(const Duration(days: 4));
                var endTime = DateTime.now();
                var results = await HealthConnectFactory.getRecord(
                  type: types.first,
                  startTime: startTime,
                  endTime: endTime,
                );
                resultText = '\ntype: $types\n\n$results';
                var jsonResults = json.encode(results);
                FirebaseAuth auth = FirebaseAuth.instance;
                User? currentUser = auth.currentUser;
                String userId = currentUser!.uid;
                var user1 = UserData();
                print(currentUser.uid);
                user1.addUser(userId, jsonResults);
                var words = await user1.getUser(userId);
                makeGetRequest();
                Navigator.pushNamed(context, Tracker.routeName);
              },
              child: const Text('Get Record'),
            ),
            Text(resultText),
          ],
        ),
      ),
    );
  }

}
