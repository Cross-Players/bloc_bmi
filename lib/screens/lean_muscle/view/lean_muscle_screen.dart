import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_height.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/lean_muscle/bloc/lean_muscle_cubit.dart';
import 'package:todo/screens/lean_muscle/bloc/lean_muscle_state.dart';

class LeanMuscleScreen extends StatefulWidget {
  const LeanMuscleScreen({super.key});

  @override
  State<LeanMuscleScreen> createState() => _LeanMuscleScreenState();
}

class _LeanMuscleScreenState extends State<LeanMuscleScreen> {
  final TextEditingController height1Controller = TextEditingController();
  final TextEditingController height2Controller = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  @override
  void dispose() {
    height1Controller.dispose();
    height2Controller.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LeanMuscleCubit(),
      child: BlocListener<LeanMuscleCubit, LeanMuscleState>(
        listenWhen:
            (previous, current) =>
                previous.leanMuscleMass != current.leanMuscleMass &&
                current.leanMuscleMass != null,
        listener: (context, state) {
          Navigator.pushNamed(
            context,
            RouteName.customResultScreen,
            arguments: {
              'result': state.leanMuscleMass,
              'title': 'Khối lương cơ nạc',
              'content':
                  'Khối lượng cơ thể nạc của bạn là : ${state.leanMuscleMass!.toInt().toString()} kg',
            },
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(title: 'Khối lượng cơ nạc'),
          body: BlocBuilder<LeanMuscleCubit, LeanMuscleState>(
            builder: (context, state) {
              final cubit = context.read<LeanMuscleCubit>();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      CustomHeight(
                        unit:
                            state.heightUnit == HeightUnit.feetInch
                                ? 'feet'
                                : 'cm',
                        height1Controller: height1Controller,
                        height2Controller: height2Controller,
                        onUnitChanged: (val) {
                          cubit.setHeightUnit(
                            val == 'feet' ? HeightUnit.feetInch : HeightUnit.cm,
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
                        unit: state.weightUnit.name,
                        weightController: weightController,
                        onUnitChanged: (val) {
                          cubit.setWeightUnit(
                            val == 'kg' ? WeightUnit.kg : WeightUnit.lbs,
                          );
                          weightController.clear();
                        },
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: CustomDrop(
                          items: ['Nam', 'Nữ'],
                          value: state.gender == Gender.male ? 'Nam' : 'Nữ',
                          onChanged: (label) {
                            final selectedGender =
                                label == 'Nam' ? Gender.male : Gender.female;
                            cubit.setGender(selectedGender);
                          },
                        ),
                      ),
                      const SizedBox(height: 50),
                      CustomButton(
                        textButton: 'Tính toán',
                        onTap: () {
                          cubit.calculateLeanMass(
                            height1: height1Controller.text.trim(),
                            height2: height2Controller.text.trim(),
                            weightText: weightController.text.trim(),
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
      ),
    );
  }
}
