import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/core/widgets/custom_text.dart';
import 'package:todo/screens/weight/bloc/weight_bloc.dart';
import 'package:todo/screens/weight/bloc/weight_event.dart';
import 'package:todo/screens/weight/bloc/weight_state.dart';
import 'package:todo/screens/weight/widgets/weight_add.dart';
import 'package:todo/screens/weight/widgets/weight_details.dart';

class WeightTitle extends StatelessWidget {
  const WeightTitle({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Row(children: [CustomText(text: 'Lịch sử'), Spacer(), WeightAdd()]),
        SizedBox(height: 20),
        BlocBuilder<WeightBloc, WeightState>(
          builder: (context, state) {
            final current = state.currentWeight ?? '--';
            final dateStr = state.currentWeightDate;
            final historyList = state.weightHistory;
            final formattedDate =
                dateStr != null
                    ? DateFormat.yMMMd().format(DateTime.parse(dateStr))
                    : 'No time';
            return ListView.separated(
              itemCount: historyList.length + 1,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 10);
              },
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  current,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  ' kg',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Text(
                              formattedDate,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          FontAwesomeIcons.barsProgress,
                          color: ColorsApp.primary,
                        ),
                        Spacer(),
                        Text(
                          '              ',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(),
                        Text(
                          '----',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.primary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                } else {
                  final item = historyList[index - 1];
                  final formattedItemDate = DateFormat.yMMMd().format(
                    DateTime.parse(item.date),
                  );
                  final itemWeight = double.tryParse(item.weight);
                  final currentWeight = double.tryParse(
                    state.currentWeight ?? '',
                  );
                  String weightChange = '--';
                  bool weightDelta = false;
                  if (itemWeight != null && currentWeight != null) {
                    final diff = itemWeight - currentWeight;
                    weightChange =
                        '${diff > 0 ? '+ ' : ''}${diff.toStringAsFixed(1)} kg';
                    weightDelta = diff > 0;
                  }
                  return WeightDetails(
                    weight: item.weight,
                    weightTime: formattedItemDate,
                    weightChange: weightChange,
                    weightDelta: weightDelta,
                    onDelete: () {
                      context.read<WeightBloc>().add(
                        DeleteWeightHistory(item.key),
                      );
                      Navigator.pop(context);
                    },
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}
