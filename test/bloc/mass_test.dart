import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo/screens/mass/bloc/mass_bloc.dart';
import 'package:todo/screens/mass/bloc/mass_event.dart';
import 'package:todo/screens/mass/bloc/mass_state.dart';

void main() {
  group('MassBloc', () {
    late MassBloc bloc;

    setUp(() {
      bloc = MassBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('initial state is MassState', () {
      expect(bloc.state, MassState());
    });

    blocTest<MassBloc, MassState>(
      'emits updated age when UpdateAge is added',
      build: () => MassBloc(),
      act: (bloc) => bloc.add(UpdateAge('25')),
      expect: () => [MassState(age: '25')],
    );

    blocTest<MassBloc, MassState>(
      'emits updated height when UpdateHeight is added with cm',
      build: () => MassBloc(),
      act:
          (bloc) =>
              bloc.add(UpdateHeight(unit: 'cm', value1: '170', value2: '')),
      expect: () => [MassState(heightUnit: 'cm', height1: '170', height2: '')],
    );

    blocTest<MassBloc, MassState>(
      'emits updated height when UpdateHeight is added with feet',
      build: () => MassBloc(),
      act:
          (bloc) =>
              bloc.add(UpdateHeight(unit: 'feet', value1: '5', value2: '7')),
      expect: () => [MassState(heightUnit: 'feet', height1: '5', height2: '7')],
    );

    blocTest<MassBloc, MassState>(
      'emits updated weight when UpdateWeight is added',
      build: () => MassBloc(),
      act: (bloc) => bloc.add(UpdateWeight(unit: 'kg', value: '70')),
      expect: () => [MassState(weightUnit: 'kg', weight: '70')],
    );

    blocTest<MassBloc, MassState>(
      'emits updated selected MassWay when SelectMassWay is added',
      build: () => MassBloc(),
      act: (bloc) => bloc.add(SelectMassWay(MassWayType.standard)),
      expect: () => [MassState(selected: MassWayType.standard)],
    );

    blocTest<MassBloc, MassState>(
      'emits MassResultState with correct BMI and category (standard)',
      build: () => MassBloc(),
      seed:
          () => MassState(
            age: '25',
            heightUnit: 'cm',
            height1: '170',
            height2: '',
            weightUnit: 'kg',
            weight: '65',
            selected: MassWayType.standard,
          ),
      act: (bloc) => bloc.add(CalculateBMI()),
      expect:
          () => [
            isA<MassResultState>()
                .having((s) => s.bmi, 'bmi', closeTo(22.49, 0.1))
                .having((s) => s.category, 'category', 'Cân nặng bình thường'),
          ],
    );

    blocTest<MassBloc, MassState>(
      'emits MassResultState with correct BMI and category (newWay)',
      build: () => MassBloc(),
      seed:
          () => MassState(
            age: '30',
            heightUnit: 'feet',
            height1: '5',
            height2: '9',
            weightUnit: 'lbs',
            weight: '154',
            selected: MassWayType.newWay,
          ),
      act: (bloc) => bloc.add(CalculateBMI()),
      expect:
          () => [
            isA<MassResultState>()
                .having((s) => s.bmi, 'bmi', closeTo(22.7, 0.5))
                .having((s) => s.category, 'category', 'Cân nặng bình thường'),
          ],
    );

    blocTest<MassBloc, MassState>(
      'does not emit when weight is invalid',
      build: () => MassBloc(),
      seed:
          () => MassState(
            heightUnit: 'cm',
            height1: '170',
            weightUnit: 'kg',
            weight: '',
            selected: MassWayType.standard,
          ),
      act: (bloc) => bloc.add(CalculateBMI()),
      expect: () => [],
    );
  });
}
