import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_text.dart';
import 'package:todo/core/widgets/custom_text_field.dart';

class CustomHeight extends StatelessWidget {
  const CustomHeight({
    super.key,
    required this.unit,
    required this.onUnitChanged,
    required this.height1Controller,
    required this.height2Controller,
  });

  final String unit;
  final ValueChanged<String> onUnitChanged;
  final TextEditingController height1Controller; // feet hoặc cm
  final TextEditingController height2Controller; // inch nếu feet

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(text: 'Nhập chiều cao'),
        const SizedBox(height: 20),
        Row(
          children: [
            if (unit == 'feet') ...[
              SizedBox(
                width: width / 3,
                child: CustomTextField(
                  textHint: 'feet',
                  controller: height1Controller,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: width / 4,
                child: CustomTextField(
                  textHint: 'inch',
                  controller: height2Controller,
                ),
              ),
              const Spacer(),
            ] else ...[
              SizedBox(
                width: width / 1.6,
                child: CustomTextField(
                  textHint: 'Nhập chiều cao',
                  controller: height1Controller,
                ),
              ),
              const Spacer(),
            ],
            SizedBox(
              width: width / 4,
              child: CustomDrop(
                items: const ['feet', 'cm'],
                value: unit,
                onChanged: onUnitChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
