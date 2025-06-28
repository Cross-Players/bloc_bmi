import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/widgets/custom_text.dart';
import 'package:todo/screens/water/bloc/water_bloc.dart';
import 'package:todo/screens/water/bloc/water_event.dart';
import 'package:todo/screens/water/bloc/water_state.dart';
import 'package:todo/screens/water/widgets/water_record_title.dart';

class WaterRecord extends StatelessWidget {
  const WaterRecord({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WaterBloc, WaterState>(
      builder: (context, state) {
        final logs = state.todayLogs;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(text: 'Bản ghi hôm nay'),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color(0xFF00C48C).withValues(alpha: 0.15),
              ),
              child:
                  logs.isEmpty
                      ? SizedBox()
                      : ListView.separated(
                        itemCount: logs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (_, __) => const SizedBox(height: 35),
                        itemBuilder: (context, index) {
                          final log = logs[index];
                          print('logs ${log.timeFormatted}');
                          return WaterRecordTitle(
                            textTime: log.timeFormatted,
                            textAmountWater: '${log.amount}ml',
                            onDelete: () {
                              context.read<WaterBloc>().add(
                                DeleteLogAtIndex(log.originalIndex),
                              );
                            },
                          );
                        },
                      ),
            ),
          ],
        );
      },
    );
  }
}
