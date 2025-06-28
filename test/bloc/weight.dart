import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/screens/weight/bloc/weight_bloc.dart';
import 'package:todo/screens/weight/bloc/weight_event.dart';
import 'package:todo/screens/weight/bloc/weight_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('WeightBloc', () {
    late SharedPreferences prefs;

    setUp(() async {
      SharedPreferences.setMockInitialValues({});
      prefs = await SharedPreferences.getInstance();
    });

    blocTest<WeightBloc, WeightState>(
      'loads current + goal weight and activity level -> step = completed',
      build: () {
        prefs.setString('currentWeight', '60');
        prefs.setString('goalWeight', '55');
        prefs.setInt('activityLevel', 2);
        prefs.setString(
          'currentWeightDate',
          DateTime(2025, 6, 28).toIso8601String(),
        );
        return WeightBloc();
      },
      act: (bloc) => bloc.add(CheckWeightStatus()),
      wait: const Duration(milliseconds: 200),
      verify: (bloc) {
        expect(bloc.state.step, WeightStep.completed);
        expect(bloc.state.currentWeight, '60');
        expect(bloc.state.goalWeight, '55');
        expect(bloc.state.activityLevel, 2);
        expect(bloc.state.targetWeightDiff, -5);
      },
    );

    blocTest<WeightBloc, WeightState>(
      'saves current weight and emits inputGoal step',
      build: () => WeightBloc(),
      act: (bloc) => bloc.add(SubmitCurrentWeight('70')),
      expect:
          () => [
            isA<WeightState>()
                .having((s) => s.currentWeight, 'currentWeight', '70')
                .having((s) => s.step, 'step', WeightStep.inputGoal),
          ],
    );

    blocTest<WeightBloc, WeightState>(
      'saves goal weight and emits inputActivity step with diff',
      build: () {
        prefs.setString('currentWeight', '80');
        return WeightBloc()
          ..emit(WeightState.initial().copyWith(currentWeight: '80'));
      },
      act: (bloc) => bloc.add(SubmitGoalWeight('90')),
      expect:
          () => [
            isA<WeightState>()
                .having((s) => s.goalWeight, 'goalWeight', '90')
                .having((s) => s.targetWeightDiff, 'diff', 10)
                .having((s) => s.step, 'step', WeightStep.inputActivity),
          ],
    );

    blocTest<WeightBloc, WeightState>(
      'saves activity level and emits completed step',
      build: () => WeightBloc(),
      act: (bloc) => bloc.add(SubmitActivityLevel(1)),
      expect:
          () => [
            isA<WeightState>()
                .having((s) => s.activityLevel, 'activityLevel', 1)
                .having((s) => s.step, 'step', WeightStep.completed),
          ],
    );

    blocTest<WeightBloc, WeightState>(
      'deletes one weight history entry and reloads',
      build: () {
        prefs.setString('weight_2025-06-28', '65');
        prefs.setString('currentWeight', '65');
        return WeightBloc();
      },
      act: (bloc) => bloc.add(DeleteWeightHistory('weight_2025-06-28')),
      wait: const Duration(milliseconds: 200),
      verify: (_) async {
        final keys = prefs.getKeys();
        expect(keys.contains('weight_2025-06-28'), false);
      },
    );

    blocTest<WeightBloc, WeightState>(
      'clears all weight data and emits initial state',
      build: () {
        prefs.setString('weight_2025-06-28', '60');
        prefs.setString('currentWeight', '60');
        prefs.setString('goalWeight', '55');
        prefs.setInt('activityLevel', 2);
        prefs.setString(
          'currentWeightDate',
          DateTime(2025, 6, 28).toIso8601String(),
        );
        return WeightBloc();
      },
      act: (bloc) => bloc.add(ClearAllWeightData()),
      wait: const Duration(milliseconds: 200),
      verify: (_) async {
        final keys = prefs.getKeys();
        expect(keys, isNot(contains('weight_2025-06-28')));
        expect(keys, isNot(contains('currentWeight')));
        expect(keys, isNot(contains('goalWeight')));
        expect(keys, isNot(contains('activityLevel')));
      },
    );
  });
}
