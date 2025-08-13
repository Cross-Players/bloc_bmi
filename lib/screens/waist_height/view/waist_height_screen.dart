import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_height.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/waist_height/bloc/waist_height_cubit.dart';
import 'package:todo/screens/waist_height/bloc/waist_height_state.dart';

class WaistHeightScreen extends StatefulWidget {
  const WaistHeightScreen({super.key});

  @override
  State<WaistHeightScreen> createState() => _WaistHeightScreenState();
}

class _WaistHeightScreenState extends State<WaistHeightScreen> {
  final TextEditingController waistController = TextEditingController();
  final TextEditingController height1Controller = TextEditingController();
  final TextEditingController height2Controller = TextEditingController();

  @override
  void dispose() {
    waistController.dispose();
    height1Controller.dispose();
    height2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WaistHeightCubit(),
      child: BlocListener<WaistHeightCubit, WaistHeightState>(
        listenWhen:
            (previous, current) =>
                previous.ratio != current.ratio && current.ratio != null,
        listener: (context, state) {
          Navigator.pushNamed(
            context,
            RouteName.customResultScreen,
            arguments: {
              'result': state.ratio,
              'title': 'Tỉ lệ eo và chiều cao',
              'content':
                  'Tỷ lệ WHtR của bạn là: ${state.ratio?.toStringAsFixed(2)}\nPhân loại: ${state.level}',
            },
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(title: 'Tỉ lệ eo và chiều cao'),
          body: BlocBuilder<WaistHeightCubit, WaistHeightState>(
            builder: (context, state) {
              final cubit = context.read<WaistHeightCubit>();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      CustomWeight(
                        textLabel: 'Nhập chu vi vòng eo',
                        textHint: 'Chu vi eo',
                        items: ['cm', 'inch'],
                        unit: state.unit.name,
                        weightController: waistController,
                        onUnitChanged: (val) {
                          cubit.setUnit(val == 'cm' ? Unit.cm : Unit.inch);
                          waistController.clear();
                        },
                      ),
                      const SizedBox(height: 20),
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
                          cubit.calculateRatio(
                            waistText: waistController.text.trim(),
                            height1: height1Controller.text.trim(),
                            height2: height2Controller.text.trim(),
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
