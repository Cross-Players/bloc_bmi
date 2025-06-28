import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/screens/weight/bloc/weight_bloc.dart';
import 'package:todo/screens/weight/bloc/weight_event.dart';
import 'package:todo/screens/weight/bloc/weight_state.dart';
import 'package:todo/screens/weight/widgets/weight_action.dart';
import 'package:todo/screens/weight/widgets/weight_content.dart';
import 'package:todo/screens/weight/widgets/weight_ques.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final TextEditingController currentWeightController = TextEditingController();
  final TextEditingController goalWeightController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context.read<WeightBloc>().add(CheckWeightStatus());
  }

  @override
  void dispose() {
    currentWeightController.dispose();
    goalWeightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Theo dõi cân nặng', isLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<WeightBloc, WeightState>(
            builder: (context, state) {
              if (state.step == WeightStep.completed) {
                return WeightContent();
              }
              return Column(
                children: [
                  if (state.step == WeightStep.inputCurrent)
                    WeightQues(
                      question: 'Cân nặng thực tế của bạn là bao nhiêu',
                      content: 'Vui lòng nhập cân nặng hiện tại của bạn',
                      isColorLine: true,
                      controller: currentWeightController,
                      onSubmitted: () {
                        final text = currentWeightController.text.trim();
                        if (text.isNotEmpty) {
                          context.read<WeightBloc>().add(
                            SubmitCurrentWeight(text),
                          );
                        }
                        currentWeightController.clear();
                      },
                    ),
                  if (state.step == WeightStep.inputGoal)
                    WeightQues(
                      question: 'Trọng lượng mục tiêu của bạn là gì?',
                      content: 'Vui lòng nhập trọng lượng mục tiêu của bạn',
                      controller: goalWeightController,
                      onSubmitted: () {
                        final text = goalWeightController.text.trim();
                        if (text.isNotEmpty) {
                          context.read<WeightBloc>().add(
                            SubmitGoalWeight(text),
                          );
                        }
                        goalWeightController.clear();
                      },
                    ),
                  if (state.step == WeightStep.inputActivity) WeightAction(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
