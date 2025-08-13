import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_height.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/body_fat/bloc/body_fat_cubit.dart';
import 'package:todo/screens/body_fat/bloc/body_fat_state.dart';

class BodyFatScreen extends StatefulWidget {
  const BodyFatScreen({super.key});

  @override
  State<BodyFatScreen> createState() => _BodyFatScreenState();
}

class _BodyFatScreenState extends State<BodyFatScreen> {
  final TextEditingController height1Controller = TextEditingController();
  final TextEditingController height2Controller = TextEditingController();
  final TextEditingController hipController = TextEditingController();

  @override
  void dispose() {
    height1Controller.dispose();
    height2Controller.dispose();
    hipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BodyFatCubit(),
      child: BlocListener<BodyFatCubit, BodyFatState>(
        listenWhen:
            (previous, current) =>
                previous.bodyFatPercent != current.bodyFatPercent &&
                current.bodyFatPercent != null,
        listener: (context, state) {
          Navigator.pushNamed(
            context,
            RouteName.customResultScreen,
            arguments: {
              'result': state.bodyFatPercent,
              'title': 'Chỉ số mỡ cơ thể',
              'content':
                  'Tỷ lệ mỡ cơ thể của bạn là: ${state.bodyFatPercent?.toStringAsFixed(1)}% \n Tỷ lệ cho thấy bạn đang ${state.level}',
            },
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(title: 'Chỉ số mỡ cơ thể'),
          body: BlocBuilder<BodyFatCubit, BodyFatState>(
            builder: (context, state) {
              final cubit = context.read<BodyFatCubit>();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 50),
                      CustomButton(
                        textButton: 'Tính toán',
                        onTap: () {
                          cubit.calculateBodyFatSimple(
                            height1: height1Controller.text.trim(),
                            height2: height2Controller.text.trim(),
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
