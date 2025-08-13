import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_text.dart';

class IdealWeightBody extends StatelessWidget {
  const IdealWeightBody({
    super.key,
    required this.onChanged,
    required this.value,
    required this.items,
    required this.textContent,
  });
  final String value;
  final ValueChanged<String> onChanged;
  final List<String> items;
  final String textContent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: textContent, isBold: true),
        SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: CustomDrop(items: items, onChanged: onChanged, value: value),
        ),
      ],
    );
  }
}
