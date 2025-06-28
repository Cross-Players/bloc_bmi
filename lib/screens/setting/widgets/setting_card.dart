import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';

class SettingCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const SettingCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: ColorsApp.primary.withValues(alpha: 0.1),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: ColorsApp.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          SizedBox(width: 16),

          // Text nội dung
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.primary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
