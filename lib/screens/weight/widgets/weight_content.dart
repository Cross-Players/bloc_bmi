import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/screens/weight/bloc/weight_bloc.dart';
import 'package:todo/screens/weight/bloc/weight_state.dart';
import 'package:todo/screens/weight/widgets/weight_index.dart';
import 'package:todo/screens/weight/widgets/weight_title.dart';

class WeightContent extends StatelessWidget {
  const WeightContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeightBloc, WeightState>(
      builder: (context, state) {
        final current = state.currentWeight ?? '--';
        final goal = state.goalWeight ?? '--';
        bool isWeightReduced = false;
        final double? startWeight = double.tryParse(current);
        final historyList = state.weightHistory;

        String weightChange = '--';

        if (startWeight != null && historyList.isNotEmpty) {
          final latestWeight = double.tryParse(historyList.first.weight);
          if (latestWeight != null) {
            final diff = latestWeight - startWeight;
            weightChange =
                '${diff > 0 ? '+ ' : ''}${diff.toStringAsFixed(1)} kg';
            isWeightReduced = diff < 0;
          }
        }
        final target =
            state.targetWeightDiff != null
                ? '+ ${state.targetWeightDiff!.toStringAsFixed(1)} kg'
                : '--';

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: WeightIndex(
                    title: 'Trọng lượng bắt đầu',
                    content: '$current kg',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: WeightIndex(
                    title: 'Cân nặng mục tiêu',
                    content: '$goal kg',
                    isColor: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: WeightIndex(
                    title: 'Đạt được',
                    content: weightChange,
                    isColor: isWeightReduced,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: WeightIndex(title: 'Bàn thắng', content: target),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              height: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorsApp.primary,
              ),
            ),
            const WeightTitle(),
          ],
        );
      },
    );
  }
}
