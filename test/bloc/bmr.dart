import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/bmr/bloc/bmr_bloc.dart';
import 'package:todo/screens/bmr/bloc/bmr_event.dart';
import 'package:todo/screens/bmr/bloc/bmr_state.dart';

void main() {
  group('BmrBloc Test', () {
    late BmrBloc bloc;

    setUp(() {
      bloc = BmrBloc();
    });

    tearDown(() {
      bloc.close();
    });

    test('Initial state is BmrState', () {
      expect(bloc.state, isA<BmrState>());
    });

    blocTest<BmrBloc, BmrState>(
      'emits state with updated age when UpdateAge is added',
      build: () => BmrBloc(),
      act: (bloc) => bloc.add(UpdateAge('25')),
      expect: () => [isA<BmrState>().having((s) => s.age, 'age', '25')],
    );

    blocTest<BmrBloc, BmrState>(
      'emits state with updated height when UpdateHeight is added',
      build: () => BmrBloc(),
      act:
          (bloc) =>
              bloc.add(UpdateHeight(unit: 'cm', value1: '170', value2: '')),
      expect:
          () => [
            isA<BmrState>()
                .having((s) => s.heightUnit, 'heightUnit', 'cm')
                .having((s) => s.height1, 'height1', '170')
                .having((s) => s.height2, 'height2', ''),
          ],
    );

    blocTest<BmrBloc, BmrState>(
      'emits state with updated weight when UpdateWeight is added',
      build: () => BmrBloc(),
      act: (bloc) => bloc.add(UpdateWeight(unit: 'kg', value: '60')),
      expect:
          () => [
            isA<BmrState>()
                .having((s) => s.weightUnit, 'weightUnit', 'kg')
                .having((s) => s.weight, 'weight', '60'),
          ],
    );

    blocTest<BmrBloc, BmrState>(
      'emits state with selected gender when SelectGender is added',
      build: () => BmrBloc(),
      act: (bloc) => bloc.add(SelectGender('Nam')),
      expect: () => [isA<BmrState>().having((s) => s.gender, 'gender', 'Nam')],
    );

    blocTest<BmrBloc, BmrState>(
      'emits BmrResultState when CalculateBMR is added with valid input',
      build: () => BmrBloc(),
      seed:
          () => BmrState(
            age: '25',
            gender: 'Nam',
            heightUnit: 'cm',
            height1: '170',
            height2: '',
            weightUnit: 'kg',
            weight: '60',
          ),
      act: (bloc) => bloc.add(CalculateBMR()),
      expect:
          () => [isA<BmrResultState>().having((s) => s.bmr, 'bmr', isNonZero)],
    );
  });
}
