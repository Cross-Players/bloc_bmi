import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_height.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/body_frame/bloc/body_frame_cubit.dart';
import 'package:todo/screens/body_frame/bloc/body_frame_state.dart';

class BodyFrameScreen extends StatefulWidget {
  const BodyFrameScreen({super.key});

  @override
  State<BodyFrameScreen> createState() => _BodyFrameScreenState();
}

class _BodyFrameScreenState extends State<BodyFrameScreen> {
  final TextEditingController height1Controller = TextEditingController();
  final TextEditingController height2Controller = TextEditingController();
  final TextEditingController wristController = TextEditingController();
  @override
  void dispose() {
    height1Controller.dispose();
    height2Controller.dispose();
    wristController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BodyFrameCubit(),
      child: BlocListener<BodyFrameCubit, BodyFrameState>(
        listenWhen:
            (previous, current) =>
                previous.frameSize != current.frameSize &&
                current.frameSize != null,
        listener: (context, state) {
          Navigator.pushNamed(
            context,
            RouteName.customResultScreen,
            arguments: {
              'result': state.ratio,
              'title': 'Kích thước khung cơ thể',
              'content':
                  'Kích thước khung cơ thể của bạn là: ${state.frameSize} (tỷ lệ: ${state.ratio?.toStringAsFixed(2)})',
            },
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(title: 'Kích thước khung cơ thể'),
          body: BlocBuilder<BodyFrameCubit, BodyFrameState>(
            builder: (context, state) {
              final cubit = context.read<BodyFrameCubit>();

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
                        textLabel: 'Nhập cổ tay',
                        textHint: 'Nhập cổ tay',
                        items: ['cm', 'inch'],
                        unit: state.wristUnit.name,
                        weightController: wristController,
                        onUnitChanged: (val) {
                          cubit.setWristUnit(
                            val == 'cm' ? WristUnit.cm : WristUnit.inch,
                          );
                          wristController.clear();
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
                          cubit.calculateFrameSize(
                            height1: height1Controller.text.trim(),
                            height2: height2Controller.text.trim(),
                            wristText: wristController.text.trim(),
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
