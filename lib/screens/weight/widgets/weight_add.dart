import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/screens/weight/bloc/weight_bloc.dart';
import 'package:todo/screens/weight/bloc/weight_event.dart';

class WeightAdd extends StatefulWidget {
  const WeightAdd({super.key});

  @override
  State<WeightAdd> createState() => _WeightAddState();
}

class _WeightAddState extends State<WeightAdd> {
  final TextEditingController _weightController = TextEditingController();
  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _saveWeight() async {
    final prefs = await SharedPreferences.getInstance();
    final String weight = _weightController.text.trim();
    final double? goal = double.tryParse(
      context.read<WeightBloc>().state.goalWeight ?? '',
    );
    final double? current = double.tryParse(weight);
    if (weight.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Vui lòng nhập cân nặng trước khi lưu.'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return; // thoát không lưu gì cả
    }
    final String timestamp =
        DateTime.now().toIso8601String(); // ví dụ: 2025-06-24T15:32:45.123
    await prefs.setString('weight_$timestamp', weight);
    await prefs.setString('currentWeightDate', timestamp);
    context.read<WeightBloc>().add(CheckWeightStatus());
    _weightController.clear();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Đã lưu cân nặng: $weight kg'),
        backgroundColor: ColorsApp.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    if (goal != null && current != null && current >= goal) {
      Navigator.pushNamed(context, RouteName.congraScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        FontAwesomeIcons.circleXmark,
                        color: ColorsApp.primary,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Cân nặng hiện tại',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: ColorsApp.primary.withValues(alpha: 0.3),
                    ),
                    child: Text(
                      DateFormat('MMM d, yyyy').format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      controller: _weightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'KG',
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 20,
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: ColorsApp.primary,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 150,
                    child: CustomButton(textButton: 'Lưu', onTap: _saveWeight),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: ColorsApp.primary,
        ),
        child: Row(
          children: [
            Icon(FontAwesomeIcons.plus, color: Colors.white, size: 15),
            SizedBox(width: 10),
            Text(
              'Thêm dữ liệu',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
