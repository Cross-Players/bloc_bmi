import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: AssetImage('assets/images/card.png'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            ColorsApp.primary.withValues(alpha: 0.8), // Lớp phủ màu xanh lá mờ
            BlendMode.srcATop,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Sức khoẻ\nTính',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Giữ dáng & tính toán chính xác bằng công cụ sức khoẻ yêu thích của bạn & một cách dễ dàng',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
