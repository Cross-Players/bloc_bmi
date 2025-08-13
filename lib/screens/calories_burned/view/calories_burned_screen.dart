import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/calories_burned/bloc/calories_burned_bloc.dart';
import 'package:todo/screens/calories_burned/bloc/calories_burned_event.dart';
import 'package:todo/screens/calories_burned/bloc/calories_burned_state.dart';

class CaloriesBurnedScreen extends StatefulWidget {
  const CaloriesBurnedScreen({super.key});

  @override
  State<CaloriesBurnedScreen> createState() => _CalorieBurnedScreenState();
}

class _CalorieBurnedScreenState extends State<CaloriesBurnedScreen> {
  late final TextEditingController distanceController;
  late final TextEditingController weightController;

  @override
  void initState() {
    super.initState();
    distanceController = TextEditingController();
    weightController = TextEditingController();
  }

  @override
  void dispose() {
    distanceController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CaloriesBurnedBloc(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Calo bị đốt cháy'),
        body: BlocConsumer<CaloriesBurnedBloc, CaloriesBurnedState>(
          listener: (context, state) {
            if (state is CaloriesBurnedResultState) {
              Navigator.pushNamed(
                context,
                RouteName.calorieBurnedResult,
                arguments: {'calories': state.calories},
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomWeight(
                      textLabel: 'Nhập trọng lượng',
                      textHint: 'Nhập trọng lượng',
                      items: ['kg', 'Ibs'],
                      unit: state.weightUnit,
                      weightController: weightController,
                      onUnitChanged: (val) {
                        context.read<CaloriesBurnedBloc>().add(
                          UpdateWeight(unit: val, value: ''),
                        );
                        weightController.clear();
                      },
                    ),
                    SizedBox(height: 20),
                    CustomWeight(
                      textLabel: 'Nhập quãng đường bạn chạy',
                      textHint: 'Nhập quãng đường bạn chạy',
                      items: ['km', 'dặm'],
                      unit: state.distanceUnit,
                      weightController: distanceController,
                      onUnitChanged: (val) {
                        context.read<CaloriesBurnedBloc>().add(
                          UpdateDistance(unit: val, value: ''),
                        );
                        distanceController.clear();
                      },
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: CustomDrop(
                        items: ['Chạy', 'Đi bộ'],
                        value: state.exerciseType,
                        onChanged: (label) {
                          context.read<CaloriesBurnedBloc>().add(
                            UpdateExerciseType(label),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(height: 50),
                    CustomButton(
                      textButton: 'Tính toán',
                      onTap: () {
                        final bloc = context.read<CaloriesBurnedBloc>();
                        bloc.add(
                          SubmitCaloriesCalculation(
                            weight: weightController.text.trim(),
                            weightUnit: state.weightUnit,
                            distance: distanceController.text.trim(),
                            distanceUnit: state.distanceUnit,
                            exerciseType: state.exerciseType,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
