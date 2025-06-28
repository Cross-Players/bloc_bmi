import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_text.dart';
import 'package:todo/screens/mass/bloc/mass_state.dart';

class MassWay extends StatelessWidget {
  final MassWayType selected;
  final ValueChanged<MassWayType> onChanged;

  const MassWay({super.key, required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(text: 'Cách thức'),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: const Color(0xFFF0F0F0),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => onChanged(MassWayType.standard),
                child: Container(
                  width: width / 2.4,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:
                        selected == MassWayType.standard
                            ? ColorsApp.primary
                            : Colors.transparent,
                  ),
                  child: Text(
                    'Tiêu chuẩn',
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          selected == MassWayType.standard
                              ? Colors.white
                              : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => onChanged(MassWayType.newWay),
                child: Container(
                  width: width / 2.4,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color:
                        selected == MassWayType.newWay
                            ? ColorsApp.primary
                            : Colors.transparent,
                  ),
                  child: Text(
                    'Mới',
                    style: TextStyle(
                      fontSize: 16,
                      color:
                          selected == MassWayType.newWay
                              ? Colors.white
                              : Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
