import 'package:flutter/material.dart';

class WaterGlassAdd extends StatelessWidget {
  const WaterGlassAdd({
    super.key,
    required this.waterAmount,
    required this.onTap,
  });
  final String waterAmount;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Image.asset(
                'assets/icon/glass.png',
                height: 55,
                width: 55,
                fit: BoxFit.cover,
              ),
              Positioned(
                top: 10,
                left: 0,
                right: 0,
                child: Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(waterAmount, style: TextStyle(fontSize: 18, color: Colors.black)),
      ],
    );
  }
}
