import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/waist_hip/bloc/waist_hip_cubit.dart';
import 'package:todo/screens/waist_hip/bloc/waist_hip_state.dart';

class WaistHipScreen extends StatefulWidget {
  const WaistHipScreen({super.key});

  @override
  State<WaistHipScreen> createState() => _WaistHipScreenState();
}

class _WaistHipScreenState extends State<WaistHipScreen> {
  final TextEditingController waistController = TextEditingController();
  final TextEditingController hipController = TextEditingController();

  @override
  void dispose() {
    waistController.dispose();
    hipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WaistHipCubit(),
      child: BlocListener<WaistHipCubit, WaistHipState>(
        listenWhen:
            (previous, current) =>
                previous.ratio != current.ratio && current.ratio != null,
        listener: (context, state) {
          Navigator.pushNamed(
            context,
            RouteName.customResultScreen,
            arguments: {
              'result': state.ratio,
              'title': 'Tỉ lệ eo / hông',
              'content':
                  'Tỉ lệ eo / hông (WHR) của bạn là: ${state.ratio?.toStringAsFixed(2)}\nPhân loại: ${state.level}',
            },
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(title: 'Tỉ lệ eo / hông'),
          body: BlocBuilder<WaistHipCubit, WaistHipState>(
            builder: (context, state) {
              final cubit = context.read<WaistHipCubit>();

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
                      CustomWeight(
                        textLabel: 'Nhập chu vi vòng hông',
                        textHint: 'Chu vi hông',
                        items: ['cm', 'inch'],
                        unit: state.unit.name,
                        weightController: hipController,
                        onUnitChanged: (val) {
                          cubit.setUnit(val == 'cm' ? Unit.cm : Unit.inch);
                          hipController.clear();
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
                            hipText: hipController.text.trim(),
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
