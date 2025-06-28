import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/calorie/bloc/calorie_bloc.dart';
import 'package:todo/screens/calorie/bloc/calorie_event.dart';
import 'package:todo/screens/calorie/bloc/calorie_state.dart';
import 'package:todo/screens/calorie/model/activity_level.dart';

void main() {
  group('CalorieBloc', () {
    late CalorieBloc bloc;

    setUp(() {
      bloc = CalorieBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is CalorieState', () {
      expect(bloc.state, isA<CalorieState>());
    });

    blocTest<CalorieBloc, CalorieState>(
      'emits updated age when UpdateAge is added',
      build: () => CalorieBloc(),
      act: (bloc) => bloc.add(UpdateAge('25')),
      expect: () => [isA<CalorieState>().having((s) => s.age, 'age', '25')],
    );

    blocTest<CalorieBloc, CalorieState>(
      'emits updated height when UpdateHeight is added',
      build: () => CalorieBloc(),
      act:
          (bloc) =>
              bloc.add(UpdateHeight(unit: 'cm', value1: '170', value2: '')),
      expect:
          () => [
            isA<CalorieState>()
                .having((s) => s.heightUnit, 'heightUnit', 'cm')
                .having((s) => s.height1, 'height1', '170')
                .having((s) => s.height2, 'height2', ''),
          ],
    );

    blocTest<CalorieBloc, CalorieState>(
      'emits updated weight when UpdateWeight is added',
      build: () => CalorieBloc(),
      act: (bloc) => bloc.add(UpdateWeight(unit: 'kg', value: '60')),
      expect:
          () => [
            isA<CalorieState>()
                .having((s) => s.weightUnit, 'weightUnit', 'kg')
                .having((s) => s.weight, 'weight', '60'),
          ],
    );

    blocTest<CalorieBloc, CalorieState>(
      'emits updated gender when SelectGender is added',
      build: () => CalorieBloc(),
      act: (bloc) => bloc.add(SelectGender('Nam')),
      expect:
          () => [isA<CalorieState>().having((s) => s.gender, 'gender', 'Nam')],
    );

    blocTest<CalorieBloc, CalorieState>(
      'emits updated activityLevel when SelectActivityLevel is added',
      build: () => CalorieBloc(),
      act:
          (bloc) =>
              bloc.add(SelectActivityLevel(ActivityLevel.moderatelyActive)),
      expect:
          () => [
            isA<CalorieState>().having(
              (s) => s.activityLevel,
              'activityLevel',
              ActivityLevel.moderatelyActive,
            ),
          ],
    );

    blocTest<CalorieBloc, CalorieState>(
      'emits CalorieResultState when CalculateTTDE is added with valid input',
      build: () => CalorieBloc(),
      seed:
          () => CalorieState(
            age: '25',
            gender: 'Nam',
            heightUnit: 'cm',
            height1: '170',
            height2: '',
            weightUnit: 'kg',
            weight: '60',
            activityLevel: ActivityLevel.moderatelyActive, // factor = 1.55
          ),
      act: (bloc) => bloc.add(CalculateTTDE()),
      expect:
          () => [
            isA<CalorieResultState>()
                .having((s) => s.tdee, 'tdee', closeTo(2438.31, 0.1))
                .having((s) => s.gender, 'gender', 'Nam')
                .having((s) => s.age, 'age', '25'),
          ],
    );

    blocTest<CalorieBloc, CalorieState>(
      'does not emit CalorieResultState when data is invalid',
      build: () => CalorieBloc(),
      act: (bloc) => bloc.add(CalculateTTDE()),
      expect: () => [], // Không emit gì nếu không đủ dữ liệu
    );
  });
}
