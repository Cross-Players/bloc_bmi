import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';

class WeightIndex extends StatelessWidget {
  const WeightIndex({
    super.key,
    required this.title,
    required this.content,
    this.isColor = false,
  });
  final String title;
  final String content;
  final bool isColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isColor ? Colors.red : ColorsApp.primary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
