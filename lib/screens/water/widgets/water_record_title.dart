import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/widgets/custom_dialog.dart';
import 'package:todo/core/widgets/custom_text.dart';

class WaterRecordTitle extends StatelessWidget {
  const WaterRecordTitle({
    super.key,
    required this.textTime,
    required this.textAmountWater,
    required this.onDelete,
  });
  final String textTime;
  final String textAmountWater;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/icon/glass.png',
          height: 20,
          width: 20,
          fit: BoxFit.cover,
        ),
        Spacer(),
        CustomText(text: textTime),
        Spacer(),
        CustomText(text: textAmountWater),
        Spacer(),
        GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder:
                  (context) => CustomDialog(
                    onDelete: () {
                      Navigator.of(context).pop();
                      onDelete();
                    },
                  ),
            );
          },
          child: FaIcon(FontAwesomeIcons.trashCan, size: 20),
        ),
      ],
    );
  }
}
