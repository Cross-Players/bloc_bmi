import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_text.dart';

class IdealWeightResultContent extends StatelessWidget {
  const IdealWeightResultContent({super.key, required this.idealWeight});
  final double idealWeight;

  @override
  Widget build(BuildContext context) {
    final double minRange = (idealWeight * 0.9).roundToDouble();
    final double maxRange = (idealWeight * 1.1).roundToDouble();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(height: 50),
          Text(
            'Kết quả',
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          CustomText(
            text:
                'Trọng lượng cơ thể lý tưởng của bạn là : ${idealWeight.toInt().toString()}kg',
            isBold: true,
          ),
          SizedBox(height: 20),
          CustomText(
            text:
                'Phạm vi trọng lượng lý tưởng của bạn là: ${minRange.toInt()} kg – ${maxRange.toInt()} kg',
            isBold: true,
          ),
          SizedBox(height: 20),
          Container(
            height: 2,
            width: 180,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  ColorsApp.primary.withValues(alpha: 0.0), // Bên trái mờ
                  ColorsApp.primary, // Ở giữa đậm
                  ColorsApp.primary.withValues(alpha: 0.0), // Bên trái mờ
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
