import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_text.dart';
import 'package:todo/screens/calorie/model/activity_level.dart';

class CalorieRadio extends StatelessWidget {
  final ActivityLevel? groupValue;
  final ValueChanged<ActivityLevel> onChanged;

  const CalorieRadio({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: 'Chọn mức độ hoạt động của bạn:'),
        SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
              ActivityLevel.values.map((level) {
                return RadioListTile<ActivityLevel>(
                  title: Text(level.description),
                  value: level,
                  groupValue: groupValue,
                  activeColor: ColorsApp.primary,
                  onChanged: (val) {
                    if (val != null) {
                      onChanged(val);
                    }
                  },
                );
              }).toList(),
        ),
      ],
    );
  }
}
