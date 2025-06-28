import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/screens/weight/bloc/weight_bloc.dart';
import 'package:todo/screens/weight/bloc/weight_event.dart';
import 'package:todo/screens/weight/bloc/weight_state.dart';

class WeightAction extends StatelessWidget {
  const WeightAction({super.key});

  final List<String> activityLevels = const [
    'Hoạt động ít vận động',
    'Hoạt động nhẹ nhàng',
    'Hoạt động vừa phải',
    'Đang hoạt động',
    'Hoạt động bổ sung',
  ];

  final List<String> activityContentLevels = const [
    'Ít hoặc không tập thể dục',
    'Tập thể dục hoặc thể thao nhẹ 1-3 ngày mỗi tuần',
    'Tập thể dục hoặc thể thao vừa phải 3-5 ngày mỗi tuần',
    'Tập thể dục hoặc thể thao chăm chỉ 6-7 ngày mỗi tuần',
    'Tập thể dục hoặc thể thao rất chăm chỉ và một công việc thể chất hoặc đào tạo gấp đôi',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeightBloc, WeightState>(
      builder: (context, state) {
        final selectedIndex = state.activityLevel ?? 0;
        return Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 250,
                height: 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorsApp.primary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Cấp độ hoạt động của bạn là gì?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...List.generate(activityLevels.length, (index) {
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  context.read<WeightBloc>().add(SelectActivityLevel(index));
                },

                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child:
                      isSelected
                          ? cardButton(
                            activityLevels[index],
                            activityContentLevels[index],
                          )
                          : cardWidget(activityLevels[index]),
                ),
              );
            }),
            const SizedBox(height: 50),
            CustomButton(
              textButton: 'Tiếp theo',
              onTap: () {
                final selectedIndex =
                    context.read<WeightBloc>().state.activityLevel;
                if (selectedIndex != null) {
                  context.read<WeightBloc>().add(
                    SubmitActivityLevel(selectedIndex),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

Widget cardWidget(String content) {
  return GestureDetector(
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
      child: Text(
        content,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.left,
      ),
    ),
  );
}

Widget cardButton(String title, String content) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: ColorsApp.primary,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withValues(alpha: 0.2),
          blurRadius: 6,
          spreadRadius: 1,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.left,
        ),
        Text(
          content,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          textAlign: TextAlign.left,
        ),
      ],
    ),
  );
}
