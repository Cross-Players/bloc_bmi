import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MassResultLine extends StatelessWidget {
  const MassResultLine({super.key, required this.bmi});
  final double bmi;

  Color getBMIColor(double bmi) {
    if (bmi < 18.5) return Colors.green;
    if (bmi < 24.9) return Colors.blue;
    if (bmi < 29.9) return Colors.yellow;
    return Colors.red;
  }

  double getBMIPercent(double bmi) {
    const minBMI = 15.0;
    const maxBMI = 35.0;
    final clampedBMI = bmi.clamp(minBMI, maxBMI);
    return (clampedBMI - minBMI) / (maxBMI - minBMI);
  }

  @override
  Widget build(BuildContext context) {
    final iconColor = getBMIColor(bmi);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final barWidth = constraints.maxWidth;
          final iconPosition = (getBMIPercent(bmi) * barWidth).clamp(
            0.0 + 7.5,
            barWidth - 7.5,
          );
          return SizedBox(
            height: 40,
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                // Thanh màu
                Positioned(
                  top: 25,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 10,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 35, // 18.5 - 15 = 3.5
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 64,
                          child: Container(color: Colors.blue),
                        ), // 24.9 - 18.5
                        Expanded(
                          flex: 50,
                          child: Container(color: Colors.yellow),
                        ), // 29.9 - 24.9
                        Expanded(
                          flex: 51,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Icon
                Positioned(
                  left: iconPosition - 7.5, // căn giữa icon ~ width 15
                  top: 0,
                  child: FaIcon(
                    FontAwesomeIcons.caretDown,
                    size: 15,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
