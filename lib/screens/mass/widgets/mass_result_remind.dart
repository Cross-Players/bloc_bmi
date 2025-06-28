import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_text.dart';

class MassResultRemind extends StatelessWidget {
  const MassResultRemind({super.key, required this.bmi});
  final double bmi;

  List<Widget> _remindList() {
    if (bmi < 18.5) {
      return [
        _contentRemind("no_drinks", "Không uống nước trước bữa ăn"),
        _contentRemind("fish", "Sử dụng đĩa lớn hơn"),
        _contentRemind("sleep", "Có được giấc ngủ chất lượng"),
      ];
    } else if (bmi < 24.9) {
      return [
        _contentRemind("run", "Luôn hoạt động"),
        _contentRemind("rice", "Chọn các loại thực phẩm phù hợp và tự nấu ăn"),
        _contentRemind("sleep", "Tập trung vào thư giãn và ngủ"),
      ];
    } else if (bmi < 29.9) {
      return [
        _contentRemind("water", "Uống nước trước bữa ăn nửa tiếng"),
        _contentRemind(
          "egg",
          "Chỉ ăn hai bữa mỗi ngày và đảm bảo chúng chứa nhiều protein",
        ),
        _contentRemind(
          "no_drinks",
          "Uống cà phê hoặc trà va tránh đồ uống có đường",
        ),
      ];
    } else {
      return [
        _contentRemind("water", "Uống trước bữa ăn nửa tiếng"),
        _contentRemind(
          "egg",
          "Chỉ ăn hai bữa mỗi ngày và đảm bảo chúng chứa nhiều protein",
        ),
        _contentRemind(
          "no_drinks",
          "Uống cà phê hoặc trà va tránh đồ uống có đường",
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _remindList(),
    );
  }
}

Widget _contentRemind(String icon, String textRemind) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3), // changes position of shadow
        ),
      ],
    ),
    child: Row(
      children: [
        Image.asset('assets/icon/$icon.png', height: 20, fit: BoxFit.cover),
        const SizedBox(width: 12),
        Expanded(child: CustomText(text: textRemind, isBold: true)),
      ],
    ),
  );
}
