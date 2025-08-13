import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/core/widgets/custom_button.dart';
import 'package:todo/core/widgets/custom_height.dart';
import 'package:todo/core/widgets/custom_weight.dart';
import 'package:todo/screens/mass/bloc/mass_bloc.dart';
import 'package:todo/screens/mass/bloc/mass_event.dart';
import 'package:todo/screens/mass/bloc/mass_state.dart';
import 'package:todo/screens/mass/widgets/mass_date.dart';
import 'package:todo/screens/mass/widgets/mass_way.dart';

class MassScreen extends StatefulWidget {
  const MassScreen({super.key});

  @override
  State<MassScreen> createState() => _MassScreenState();
}

class _MassScreenState extends State<MassScreen> {
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
      create: (_) => MassBloc(),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Chỉ số khối cơ thể'),
        body: BlocConsumer<MassBloc, MassState>(
          listener: (context, state) {
            if (state is MassResultState) {
              Navigator.pushNamed(
                context,
                RouteName.massResult,
                arguments: {'bmi': state.bmi, 'category': state.category},
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
                    MassDate(controller: ageController),
                    const SizedBox(height: 20),
                    CustomHeight(
                      unit: state.heightUnit,
                      height1Controller: height1Controller,
                      height2Controller: height2Controller,
                      onUnitChanged: (val) {
                        context.read<MassBloc>().add(
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
                        context.read<MassBloc>().add(
                          UpdateWeight(unit: val, value: ''),
                        );
                        weightController.clear();
                      },
                    ),
                    const SizedBox(height: 20),
                    MassWay(
                      selected: state.selected,
                      onChanged: (val) {
                        context.read<MassBloc>().add(SelectMassWay(val));
                      },
                    ),
                    const SizedBox(height: 50),
                    CustomButton(
                      textButton: 'Tính toán',
                      onTap: () {
                        final bloc = context.read<MassBloc>();

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
                        bloc.add(CalculateBMI());
                      },
                    ),
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
