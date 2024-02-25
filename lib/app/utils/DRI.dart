
double calculateBMR(double weight, double height, int age, String sex) {
  if (sex == 'male') {
    return 66.47 + 13.75 * weight + 5.003 * height - 6.755 * age;
  } else {
    return 655.1 + 9.563 * weight + 1.85 * height - 4.676 * age;
  }
}

double calculateDailyCalorieNeeds(double bmr, String activityLevel) {
  final activityLevelFactors = {
    'sedentary': 1.2,
    'lightly active': 1.375,
    'moderately active': 1.55,
    'very active': 1.725,
    'extra active': 1.9,
  };

  return bmr * activityLevelFactors[activityLevel]!;
}

 Map<String, num> calculateNutrientRecommendations(
    double dailyCalorieNeeds, String sex, int age) {
  final adultNutrientRecommendations = {
    'protein': 0.8 * dailyCalorieNeeds / 4,
    'carbohydrates': 4 * dailyCalorieNeeds / 4,
    'fat': 0.2 * dailyCalorieNeeds / 9,
    'fiber': 25,
    'calcium': 1000,
    'iron': 8,
    'vitamin A': 900,
    'vitamin C': 90,
    'vitamin D': 600,
    'vitamin E': 15,
    'vitamin K': 120,
    'thiamin': 1.2,
    'riboflavin': 1.3,
    'niacin': 16,
    'vitamin B6': 1.3,
    'folate': 400,
    'vitamin B12': 2.4,
    'pantothenic acid': 5,
    'biotin': 30,
    'choline': 550,
    'selenium': 55,
    'zinc': 11,
    'copper': 0.9,
    'manganese': 2.3,
    'chromium': 35,
    'molybdenum': 45,
    'iodine': 150,
    'potassium': 4700,
    'magnesium': 400,
    'phosphorus': 700,
    'sodium': 2300,
  };

  final childNutrientRecommendations = {
    'protein': 0.95 * dailyCalorieNeeds / 4,
    'carbohydrates': 4 * dailyCalorieNeeds / 4,
    'fat': 0.2 * dailyCalorieNeeds / 9,
    'fiber': 20,
    'calcium': 1300,
    'iron': 10,
    'vitamin A': 700,
    'vitamin C': 65,
    'vitamin D': 600,
    'vitamin E': 11,
    'vitamin K': 75,
    'thiamin': 0.9,
    'riboflavin': 0.9,
    'niacin': 12,
    'vitamin B6': 1.0,
    'folate': 400,
    'vitamin B12': 2.4,
    'pantothenic acid': 4,
    'biotin': 25,
    'choline': 550,
    'selenium': 40,
    'zinc': 8,
    'copper': 0.7,
    'manganese': 1.6,
    'chromium': 25,
    'molybdenum': 30,
    'iodine': 120,
    'potassium': 3500,
    'magnesium': 360,
    'phosphorus': 500,
    'sodium': 2000,
  };

  // Choose the appropriate nutrient recommendations based on age
  final nutrientRecommendations =
      age >= 19 ? adultNutrientRecommendations : childNutrientRecommendations;

  return nutrientRecommendations;
}

void main() {
  // Calculate the BMR, daily calorie needs, and nutrient recommendations for a
  // 30-year-old male who weighs 75 kg, is 180 cm tall, and has a moderately
  // active lifestyle.
  final bmr = calculateBMR(75, 180, 30, 'male');
  final dailyCalorieNeeds = calculateDailyCalorieNeeds(bmr, 'moderately active');
  final nutrientRecommendations =
      calculateNutrientRecommendations(dailyCalorieNeeds, 'male', 30);

  // Print the results
  print('BMR: ${bmr.toStringAsFixed(2)} kcal/day');
  print('Daily calorie needs: ${dailyCalorieNeeds.toStringAsFixed(2)} kcal/day');
  print('Nutrient recommendations:');
  nutrientRecommendations.forEach((nutrient, recommendation) {
    print('  $nutrient: ${recommendation.toStringAsFixed(2)} mg/day');
  });
}