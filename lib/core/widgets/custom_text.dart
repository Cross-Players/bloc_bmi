import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text, this.isBold = false});
  final String text;
  final bool isBold;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
      ),
    );
  }
}
