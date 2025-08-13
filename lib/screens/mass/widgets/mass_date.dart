import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_text.dart';
import 'package:todo/core/widgets/custom_text_field.dart';

class MassDate extends StatelessWidget {
  final TextEditingController controller;

  const MassDate({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(text: 'Nhập tuổi'),
        const SizedBox(height: 20),
        CustomTextField(textHint: 'Nhập tuổi', controller: controller),
      ],
    );
  }
}
