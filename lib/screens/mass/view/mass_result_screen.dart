import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/screens/mass/widgets/mass_result_bmi.dart';
import 'package:todo/screens/mass/widgets/mass_result_line.dart';
import 'package:todo/screens/mass/widgets/mass_result_rate.dart';
import 'package:todo/screens/mass/widgets/mass_result_remind.dart';

class MassResultScreen extends StatelessWidget {
  const MassResultScreen({
    super.key,
    required this.bmi,
    required this.category,
  });
  final double bmi;
  final String category;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Chỉ số khối cơ thể'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              MassResultBmi(resultBmi: bmi),
              SizedBox(height: 20),
              MassResultLine(bmi: bmi),
              SizedBox(height: 20),
              MassResultRate(category: category, bmi: bmi),
              SizedBox(height: 20),
              MassResultRemind(bmi: bmi),
            ],
          ),
        ),
      ),
    );
  }
}
