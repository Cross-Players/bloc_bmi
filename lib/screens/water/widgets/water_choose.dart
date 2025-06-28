import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/screens/water/bloc/water_bloc.dart';
import 'package:todo/screens/water/bloc/water_event.dart';

class WaterChoose extends StatelessWidget {
  const WaterChoose({super.key});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final parentContext = context;
        showDialog(
          context: context,
          builder: (dialogContext) {
            int selectedAmount = 250;
            bool isSwitchOn = false;
            String customInput = '';
            return StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  backgroundColor: Colors.white,
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 20),
                      ...[
                        Wrap(
                          spacing: 25,
                          runSpacing: 15,
                          children: [
                            _glassIcon(
                              'glass_1',
                              '100ml',
                              !isSwitchOn &&
                                  selectedAmount == 100, // <-- Thêm !isSwitchOn
                              isSwitchOn,
                              () {
                                setState(() {
                                  selectedAmount = 100;
                                });
                              },
                            ),
                            _glassIcon(
                              'glass_2',
                              '150ml',
                              !isSwitchOn && selectedAmount == 150,
                              isSwitchOn,
                              () {
                                setState(() {
                                  selectedAmount = 150;
                                });
                              },
                            ),
                            _glassIcon(
                              'glass_3',
                              '200ml',
                              !isSwitchOn && selectedAmount == 200,
                              isSwitchOn,
                              () {
                                setState(() {
                                  selectedAmount = 200;
                                });
                              },
                            ),
                            _glassIcon(
                              'glass_4',
                              '250ml',
                              !isSwitchOn && selectedAmount == 250,
                              isSwitchOn,
                              () {
                                setState(() {
                                  selectedAmount = 250;
                                });
                              },
                            ),
                            _glassIcon(
                              'glass_5',
                              '300ml',
                              !isSwitchOn && selectedAmount == 300,
                              isSwitchOn,
                              () {
                                setState(() {
                                  selectedAmount = 300;
                                });
                              },
                            ),
                            _glassIcon(
                              'glass_6',
                              '350ml',
                              !isSwitchOn && selectedAmount == 350,
                              isSwitchOn,
                              () {
                                setState(() {
                                  selectedAmount = 350;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Tùy chỉnh', style: TextStyle(fontSize: 20)),
                          Switch(
                            value: isSwitchOn,
                            onChanged: (value) {
                              setState(() {
                                isSwitchOn = value;
                              });
                            },
                            activeColor: ColorsApp.primary,
                          ),
                        ],
                      ),
                      if (isSwitchOn)
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/glass.png',
                              height: 20,
                              width: 20,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  hintText: 'Nhập dung tích...',
                                  hintStyle: TextStyle(
                                    color: ColorsApp.primary,
                                  ),
                                  border: UnderlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(
                                    3,
                                  ), // Giới hạn 3 ký tự
                                  FilteringTextInputFormatter
                                      .digitsOnly, // Chỉ cho phép số
                                ],
                                onChanged: (value) => customInput = value,
                              ),
                            ),
                          ],
                        ),
                      SizedBox(height: 30),
                      CustomButton(
                        textButton: 'Xong',
                        onTap: () {
                          int? amount;
                          if (isSwitchOn && customInput.isNotEmpty) {
                            amount = int.tryParse(customInput);
                          } else {
                            amount = selectedAmount;
                          }
                          if (amount != null && amount > 0) {
                            // Lưu vào SharedPreferences
                            SharedPreferences.getInstance().then((prefs) {
                              prefs.setInt('selected_water_amount', amount!);
                            });
                            parentContext.read<WaterBloc>().add(
                              SelectAmount(amount),
                            );
                          }
                          Navigator.pop(dialogContext);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/icon/glass.png',
              height: 30,
              width: 30,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: -5,
            right: -2,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.white,
              ),
              child: FaIcon(
                FontAwesomeIcons.arrowsRotate,
                size: 15,
                color: ColorsApp.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _glassIcon(
  String iconPath,
  String textWater,
  bool isSelected,
  bool isSwitchOn,
  VoidCallback onTap,
) {
  final iconWidget = InkWell(
    onTap: onTap,
    child: Column(
      children: [
        Image.asset('assets/icons_glass/$iconPath.png', height: 40, width: 40),
        SizedBox(height: 10),
        Text(textWater),
      ],
    ),
  );

  return Padding(
    padding: const EdgeInsets.all(5),
    child: Container(
      decoration: BoxDecoration(
        color:
            isSwitchOn
                ? Colors.transparent
                : isSelected
                ? const Color(0xFF00C48C).withValues(alpha: 0.3)
                : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        border:
            isSwitchOn
                ? null
                : isSelected
                ? Border.all(color: const Color(0xFF00C48C), width: 2)
                : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: iconWidget,
    ),
  );
}
