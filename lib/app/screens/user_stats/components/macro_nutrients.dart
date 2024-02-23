import 'package:flutter/material.dart';

class MacroNutrient {
  final String name;
  final double target;
  final double current;

  MacroNutrient({
    required this.name,
    required this.target,
    required this.current,
  });
}

class MacroNutrientProgress extends StatelessWidget {
  final MacroNutrient nutrient;

  const MacroNutrientProgress({super.key, required this.nutrient});

  @override
  Widget build(BuildContext context) {
    double progress = nutrient.current / nutrient.target;

    return Column(
      children: [
        Text(
          nutrient.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[300],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 8),
        Text(
          'Progress: ${(progress * 100).toStringAsFixed(1)}%',
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
