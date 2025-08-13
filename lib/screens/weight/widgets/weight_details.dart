import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_dialog.dart';

class WeightDetails extends StatelessWidget {
  const WeightDetails({
    super.key,
    required this.weight,
    required this.weightTime,
    required this.weightChange,
    required this.weightDelta,
    required this.onDelete,
  });
  final String weight;
  final String weightTime;
  final String weightChange;
  final bool weightDelta;
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    weight,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    ' kg',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Text(
                weightTime,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Spacer(),
          Icon(
            weightDelta
                ? FontAwesomeIcons.arrowTrendUp
                : FontAwesomeIcons.arrowTrendDown,
            color: weightDelta ? ColorsApp.primary : Colors.red,
          ),
          Spacer(),
          Text(
            weightChange,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: weightDelta ? ColorsApp.primary : Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CustomDialog(onDelete: onDelete);
                },
              );
            },
            child: Icon(FontAwesomeIcons.trashCan, color: ColorsApp.primary),
          ),
        ],
      ),
    );
  }
}
