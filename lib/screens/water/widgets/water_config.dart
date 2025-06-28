import 'package:flutter/material.dart';

class WaterConfig extends StatelessWidget {
  const WaterConfig({
    super.key,
    required this.textConfig,
    required this.textTotal,
  });
  final String textConfig;
  final String textTotal;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              textConfig,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text('/ 3025', style: TextStyle(fontSize: 20, color: Colors.black)),
          ],
        ),
        SizedBox(height: 10),
        Text(
          'Còn lại: $textTotal ml',
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
      ],
    );
  }
}
