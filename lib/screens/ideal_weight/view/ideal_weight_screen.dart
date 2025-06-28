import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_drop.dart';
import 'package:todo/core/widgets/custom_height.dart';
import 'package:todo/screens/ideal_weight/bloc/ideal_weight_cubit.dart';
import 'package:todo/screens/ideal_weight/bloc/ideal_weight_state.dart';
import 'package:todo/screens/ideal_weight/widgets/ideal_weight_body.dart';

class IdealWeightScreen extends StatefulWidget {
  const IdealWeightScreen({super.key});

  @override
  State<IdealWeightScreen> createState() => _IdealWeightScreenState();
}

class _IdealWeightScreenState extends State<IdealWeightScreen> {
  final TextEditingController height1Controller = TextEditingController();
  final TextEditingController height2Controller = TextEditingController();
  final List<String> itemsHeight = ['Ánh sáng', 'Trung bình', 'Nặng'];
  @override
  void dispose() {
    height1Controller.dispose();
    height2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => IdealWeightCubit(),
      child: BlocListener<IdealWeightCubit, IdealWeightState>(
        listenWhen:
            (previous, current) =>
                previous.idealWeight != current.idealWeight &&
                current.idealWeight != null,
        listener: (context, state) {
          Navigator.pushNamed(
            context,
            RouteName.weightResult,
            arguments: {'idealWeight': state.idealWeight},
          );
        },
        child: Scaffold(
          appBar: CustomAppBar(title: 'Trọng lượng cơ thể lý tưởng'),
          body: BlocBuilder<IdealWeightCubit, IdealWeightState>(
            builder: (context, state) {
              final cubit = context.read<IdealWeightCubit>();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      IdealWeightBody(
                        textContent: 'Chọn khung body của bạn:',
                        items: itemsHeight,
                        value: itemsHeight[state.frame?.index ?? 0],
                        onChanged: (label) {
                          final index = itemsHeight.indexOf(label);
                          cubit.setFrame(BodyFrame.values[index]);
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
                          cubit.calculateFromInput(
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
