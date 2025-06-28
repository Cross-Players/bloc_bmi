import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_text.dart';

class CaloriesBurnedCard extends StatelessWidget {
  const CaloriesBurnedCard({super.key, required this.calories});
  final double calories;

  String _getMessage(double calo) {
    if (calo < 100) {
      return 'Chỉ mới bắt đầu, cố lên nhé!';
    } else if (calo < 200) {
      return 'Tốt hơn hết bạn nên bắt tay vào làm việc!';
    } else if (calo < 400) {
      return 'Bạn đang đi đúng hướng, tiếp tục nào!';
    } else if (calo < 600) {
      return 'Tuyệt vời! Đó là một buổi tập hiệu quả!';
    } else {
      return 'Bạn như một chiến binh thực thụ!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                'Bạn đã đốt thành công: \n${calories.toInt().toString()} Calo',
            isBold: true,
          ),
          CustomText(text: _getMessage(calories)),
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
