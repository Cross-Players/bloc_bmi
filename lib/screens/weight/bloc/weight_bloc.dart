import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/weight/model/weight_history.dart';
import 'weight_event.dart';
import 'weight_state.dart';

class WeightBloc extends Bloc<WeightEvent, WeightState> {
  WeightBloc() : super(WeightState.initial()) {
    on<CheckWeightStatus>(_onCheckWeightStatus);
    on<SubmitCurrentWeight>(_onSubmitCurrentWeight);
    on<SubmitGoalWeight>(_onSubmitGoalWeight);
    on<SubmitActivityLevel>(_onSubmitActivityLevel);
    on<SelectActivityLevel>((event, emit) {
      emit(state.copyWith(activityLevel: event.levelIndex));
    });
    on<DeleteWeightHistory>(_onDeleteWeightHistory);
    on<ClearAllWeightData>(_onClearAllWeightData);
  }

  Future<void> _onCheckWeightStatus(
    CheckWeightStatus event,
    Emitter<WeightState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getString('currentWeight');
    final goal = prefs.getString('goalWeight');
    final level = prefs.getInt('activityLevel');
    final date = prefs.getString('currentWeightDate');
    final keys = prefs.getKeys();
    final history = <WeightHistory>[];
    for (final key in keys) {
      if (key.startsWith('weight_')) {
        final date = key.replaceFirst('weight_', '');
        final weight = prefs.getString(key);
        if (weight != null) {
          history.add(WeightHistory(key: key, date: date, weight: weight));
        }
      }
    }
    history.sort((a, b) => b.date.compareTo(a.date));
    double? diff;
    if (current != null && goal != null) {
      final c = double.tryParse(current);
      final g = double.tryParse(goal);
      if (c != null && g != null) {
        diff = g - c;
      }
      emit(
        WeightState(
          step: WeightStep.completed,
          currentWeight: current,
          goalWeight: goal,
          activityLevel: level,
          currentWeightDate: date,
          targetWeightDiff: diff,
          weightHistory: history,
        ),
      );
    } else if (current != null) {
      emit(
        WeightState(
          step: WeightStep.inputGoal,
          currentWeight: current,
          currentWeightDate: date,
          weightHistory: history,
        ),
      );
    } else {
      emit(WeightState.initial());
    }
  }

  Future<void> _onSubmitCurrentWeight(
    SubmitCurrentWeight event,
    Emitter<WeightState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('currentWeight', event.weight);
    final now = DateTime.now().toIso8601String();
    await prefs.setString('currentWeightDate', now);
    emit(
      state.copyWith(
        step: WeightStep.inputGoal,
        currentWeight: event.weight,
        currentWeightDate: now,
      ),
    );
  }

  Future<void> _onSubmitGoalWeight(
    SubmitGoalWeight event,
    Emitter<WeightState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('goalWeight', event.weight);
    final current = state.currentWeight;
    double? diff;
    if (current != null) {
      final c = double.tryParse(current);
      final g = double.tryParse(event.weight);
      if (c != null && g != null) {
        diff = g - c;
      }
    }
    emit(
      state.copyWith(
        step: WeightStep.inputActivity,
        goalWeight: event.weight,
        targetWeightDiff: diff,
      ),
    );
  }

  Future<void> _onSubmitActivityLevel(
    SubmitActivityLevel event,
    Emitter<WeightState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('activityLevel', event.levelIndex);
    emit(
      state.copyWith(
        step: WeightStep.completed,
        activityLevel: event.levelIndex,
      ),
    );
  }

  Future<void> _onClearAllWeightData(
    ClearAllWeightData event,
    Emitter<WeightState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();

    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith('weight_') ||
          key == 'currentWeight' ||
          key == 'goalWeight' ||
          key == 'activityLevel' ||
          key == 'currentWeightDate') {
        await prefs.remove(key);
      }
    }

    emit(WeightState.initial());
  }

  Future<void> _onDeleteWeightHistory(
    DeleteWeightHistory event,
    Emitter<WeightState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(event.key);
    add(CheckWeightStatus());
  }
}
