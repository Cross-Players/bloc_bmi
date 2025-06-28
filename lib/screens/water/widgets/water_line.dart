import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';

class WaterLine extends StatelessWidget {
  const WaterLine({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 250,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorsApp.primary,
        ),
      ),
    );
  }
}
