import 'package:flutter_health_connect/flutter_health_connect.dart';

void addNutritionToHealthConnect(name, protein, carbs, fat, calories) async {
  // Check if Google Health Connect is available

  await HealthConnectFactory.writeData(
    type: HealthConnectDataType.Nutrition,
    data: [
      NutritionRecord(
        endTime: DateTime.now(),
        startTime: DateTime.now(),
        protein: protein,
        totalCarbohydrates: carbs,
        totalFat: fat,
        energy: calories,
        name: name,
      )
    ],
  );
}
