import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class GoalsCard extends StatelessWidget {
  final int goal;
  final int progress;

  const GoalsCard({Key? key, required this.goal, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double progressPercentage = (progress / goal) * 100;

    return Card(
      color: Colors.grey[900], // Set card background color to dark grey
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Calorie Goals for Today',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Set text color to white
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: MediaQuery.of(context).size.width *
                  0.8, // Set container width to fit horizontally perfectly
              height: MediaQuery.of(context).size.width *
                  0.8, // Set container height to fill the available space
              decoration: BoxDecoration(
                shape: BoxShape.rectangle, // Set container shape to rectangle
                color: Colors.grey[800], // Set container color to dark grey
              ),
              child: Stack(
                children: [
                  Center(
                      child: Container(
                          child: SfRadialGauge(axes: <RadialAxis>[
                    RadialAxis(minimum: 0, maximum: goal.toDouble(), ranges: <GaugeRange>[
                      GaugeRange(
                          startValue: 0, endValue: 50, color: Colors.green),
                      GaugeRange(
                          startValue: 50, endValue: 100, color: Colors.orange),
                      GaugeRange(
                          startValue: 100, endValue: 150, color: Colors.red)
                    ], pointers: <GaugePointer>[
                      NeedlePointer(value: progress.toDouble())
                    ], annotations: <GaugeAnnotation>[
                      GaugeAnnotation(
                          widget: Container(
                              child: Text('90.0',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                          angle: 90,
                          positionFactor: 0.5)
                    ])
                  ]))),
                  Center(
                    child: Text(
                      '${progressPercentage.toStringAsFixed(1)}%',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Set text color to white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
