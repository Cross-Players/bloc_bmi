import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_height.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/calorie/bloc/calorie_bloc.dart';
import 'package:todo/screens/calorie/bloc/calorie_state.dart';
import 'package:todo/screens/calorie/widgets/calorie_radio.dart';
import 'package:todo/screens/calorie/bloc/calorie_event.dart';

class CalorieScreen extends StatefulWidget {
  const CalorieScreen({super.key});

  @override
  State<CalorieScreen> createState() => _CalorieScreenState();
}

class _CalorieScreenState extends State<CalorieScreen> {
  late final TextEditingController ageController;
  late final TextEditingController weightController;
  late final TextEditingController height1Controller;
  late final TextEditingController height2Controller;

  @override
  void initState() {
    super.initState();
    ageController = TextEditingController();
    weightController = TextEditingController();
    height1Controller = TextEditingController();
    height2Controller = TextEditingController();
  }

  @override
  void dispose() {
    ageController.dispose();
    weightController.dispose();
    height1Controller.dispose();
    height2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CalorieBloc(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Lượng calo hàng ngày'),
        body: BlocConsumer<CalorieBloc, CalorieState>(
          listener: (context, state) {
            if (state is CalorieResultState) {
              Navigator.pushNamed(
                context,
                RouteName.calorieResult,
                arguments: {
                  'tdee': state.tdee,
                  'activityLevel': state.activityLevel,
                },
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
                      textLabel: 'Nhập tuổi',
                      textHint: 'Nhập tuổi',
                      items: ['Nam', 'Nữ'],
                      unit: state.gender,
                      weightController: ageController,
                      onUnitChanged: (val) {
                        context.read<CalorieBloc>().add(SelectGender(val));
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomHeight(
                      unit: state.heightUnit,
                      height1Controller: height1Controller,
                      height2Controller: height2Controller,
                      onUnitChanged: (val) {
                        context.read<CalorieBloc>().add(
                          UpdateHeight(unit: val, value1: '', value2: ''),
                        );
                        height1Controller.clear();
                        height2Controller.clear();
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomWeight(
                      textLabel: 'Nhập trọng lượng',
                      textHint: 'Nhập trọng lượng',
                      items: ['kg', 'Ibs'],
                      unit: state.weightUnit,
                      weightController: weightController,
                      onUnitChanged: (val) {
                        context.read<CalorieBloc>().add(
                          UpdateWeight(unit: val, value: ''),
                        );
                        weightController.clear();
                      },
                    ),
                    SizedBox(height: 20),
                    CalorieRadio(
                      groupValue:
                          state
                              .activityLevel, // nếu `state.activityLevel` nullable
                      onChanged: (val) {
                        context.read<CalorieBloc>().add(
                          SelectActivityLevel(val),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      textButton: 'Tính toán',
                      onTap: () {
                        final bloc = context.read<CalorieBloc>();
                        bloc.add(UpdateAge(ageController.text.trim()));
                        bloc.add(
                          UpdateWeight(
                            unit: state.weightUnit,
                            value: weightController.text.trim(),
                          ),
                        );
                        bloc.add(
                          UpdateHeight(
                            unit: state.heightUnit,
                            value1: height1Controller.text.trim(),
                            value2: height2Controller.text.trim(),
                          ),
                        );
                        bloc.add(CalculateTTDE());
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
