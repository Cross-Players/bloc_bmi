import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_text.dart';
import 'package:todo/core/widgets/custom_text_field.dart';

class CustomWeight extends StatelessWidget {
  final String unit;
  final TextEditingController weightController;
  final ValueChanged<String> onUnitChanged;
  final String textLabel;
  final String textHint;
  final List<String> items;

  const CustomWeight({
    super.key,
    required this.unit,
    required this.weightController,
    required this.onUnitChanged,
    required this.textLabel,
    required this.textHint,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(text: textLabel),
        const SizedBox(height: 20),
        Row(
          children: [
            SizedBox(
              width: width / 1.6,
              child: CustomTextField(
                textHint: textHint,
                controller: weightController,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: width / 4,
              child: CustomDrop(
                items: items,
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
