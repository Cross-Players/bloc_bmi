import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_button.dart';

class WeightQues extends StatelessWidget {
  const WeightQues({
    super.key,
    required this.question,
    required this.content,
    this.isColorLine = false,
    required this.controller,
    required this.onSubmitted,
  });
  final String question;
  final String content;
  final bool isColorLine;
  final TextEditingController controller;
  final VoidCallback onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Center(
          child: Container(
            width: 250,
            height: 5,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: ColorsApp.primary, // nửa trái: xám
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isColorLine
                              ? Color(0xFFEEEEEE)
                              : ColorsApp.primary, // nửa phải: màu chính
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEEEEEE), // nửa phải: màu chính
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Text(
          question,
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        Text(
          content,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'KG',
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
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
                borderSide: BorderSide(color: ColorsApp.primary, width: 2),
              ),
            ),
          ),
        ),
        SizedBox(height: 100),
        CustomButton(textButton: 'Tiếp theo', onTap: onSubmitted),
      ],
    );
  }
}
