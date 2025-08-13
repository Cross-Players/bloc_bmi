import 'package:flutter/material.dart';

class MassResultRate extends StatelessWidget {
  const MassResultRate({super.key, required this.category, required this.bmi});
  final String category;
  final double bmi;
  @override
  Widget build(BuildContext context) {
    String getBMICategoryImage(double bmi) {
      if (bmi < 18.5) {
        return 'underweight'; // Underweight
      } else if (bmi < 24.9) {
        return 'normal'; // Normal
      } else if (bmi < 29.9) {
        return 'overweight'; // Overweight
      } else {
        return 'obese'; // Obese
      }
    }

    return Column(
      children: [
        Image.asset('assets/images/${getBMICategoryImage(bmi)}.png'),
        SizedBox(height: 10),
        Text(
          category,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
