import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_text.dart';

class MassResultBmi extends StatelessWidget {
  const MassResultBmi({super.key, required this.resultBmi});
  final double resultBmi;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          CustomText(text: 'Chỉ số khối cơ thể của bạn', isBold: true),
          Text(
            resultBmi.toStringAsFixed(2),
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
