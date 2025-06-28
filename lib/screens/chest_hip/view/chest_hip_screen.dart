import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/chest_hip/bloc/chest_hip_cubit.dart';
import 'package:todo/screens/chest_hip/bloc/chest_hip_state.dart';

class ChestHipScreen extends StatefulWidget {
  const ChestHipScreen({super.key});

  @override
  State<ChestHipScreen> createState() => _ChestHipScreenState();
}

class _ChestHipScreenState extends State<ChestHipScreen> {
  final TextEditingController chestController = TextEditingController();
  final TextEditingController hipController = TextEditingController();

  @override
  void dispose() {
    chestController.dispose();
    hipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChestHipCubit(),
      child: BlocListener<ChestHipCubit, ChestHipState>(
        listenWhen:
            (previous, current) =>
                previous.ratio != current.ratio && current.ratio != null,
        listener: (context, state) {
          Navigator.pushNamed(
            context,
            RouteName.customResultScreen,
            arguments: {
              'result': state.ratio,
              'title': 'Tỉ lệ ngực / hông',
              'content':
                  'Tỷ lệ ngực / hông của bạn là: ${state.ratio?.toStringAsFixed(2)}\nPhân loại: ${state.level}',
            },
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(title: 'Tỉ lệ ngực / hông'),
          body: BlocBuilder<ChestHipCubit, ChestHipState>(
            builder: (context, state) {
              final cubit = context.read<ChestHipCubit>();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      CustomWeight(
                        textLabel: 'Nhập chu vi ngực',
                        textHint: 'Chu vi ngực',
                        items: ['cm', 'inch'],
                        unit: state.unit.name,
                        weightController: chestController,
                        onUnitChanged: (val) {
                          cubit.setUnit(val == 'cm' ? Unit.cm : Unit.inch);
                          chestController.clear();
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomWeight(
                        textLabel: 'Nhập chu vi hông',
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
                            chestText: chestController.text.trim(),
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
