import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key, required this.onDelete});
  final VoidCallback onDelete;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Text(
        'Xóa mục nhập ?',
        style: TextStyle(
          fontSize: 25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Bạn có chắc chắn muốn xóa không?',
        style: TextStyle(fontSize: 20, color: Colors.black),
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: _widgetButton(
                'Không',

                () => Navigator.of(context).pop(),
                false,
              ),
            ),
            SizedBox(width: 10),
            Expanded(child: _widgetButton('Có', onDelete, true)),
          ],
        ),
      ],
    );
  }
}

Widget _widgetButton(String textButton, VoidCallback onTap, bool isColor) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: isColor ? ColorsApp.primary : Colors.transparent,
        border: Border.all(color: ColorsApp.primary, width: 1.5),
      ),

      child: Text(
        textButton,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: isColor ? Colors.white : Colors.black,
        ),
      ),
    ),
  );
}
