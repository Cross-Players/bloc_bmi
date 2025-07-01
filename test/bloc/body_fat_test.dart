import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/body_fat/bloc/body_fat_state.dart';
import 'package:todo/screens/body_fat/bloc/body_fat_cubit.dart';

void main() {
  group('BodyFatCubit', () {
    late BodyFatCubit cubit;

    setUp(() {
      cubit = BodyFatCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is BodyFatState', () {
      expect(cubit.state, const BodyFatState());
    });

    blocTest<BodyFatCubit, BodyFatState>(
      'emits state with updated gender',
      build: () => BodyFatCubit(),
      act: (cubit) => cubit.setGender(Gender.male),
      expect: () => [const BodyFatState(gender: Gender.male)],
    );

    blocTest<BodyFatCubit, BodyFatState>(
      'emits state with updated heightUnit',
      build: () => BodyFatCubit(),
      act: (cubit) => cubit.setHeightUnit(HeightUnit.feetInch),
      expect: () => [BodyFatState(heightUnit: HeightUnit.feetInch)],
    );

    blocTest<BodyFatCubit, BodyFatState>(
      'emits state with calculated body fat (cm, cm)',
      build: () {
        final cubit = BodyFatCubit();
        cubit.setHeightUnit(HeightUnit.cm);
        cubit.setUnit(Unit.cm);
        return cubit;
      },
      act:
          (cubit) => cubit.calculateBodyFatSimple(
            height1: '170',
            height2: '',
            hipText: '85',
          ),
      expect:
          () => [
            isA<BodyFatState>()
                .having((s) => s.bodyFatPercent, 'percent', closeTo(50.0, 0.1))
                .having((s) => s.level, 'level', 'Normal'),
          ],
    );

    blocTest<BodyFatCubit, BodyFatState>(
      'emits null bodyFatPercent when invalid input',
      build: () => BodyFatCubit(),
      act:
          (cubit) => cubit.calculateBodyFatSimple(
            height1: '',
            height2: '',
            hipText: '',
          ),
      expect: () => [const BodyFatState(bodyFatPercent: null, level: null)],
    );
  });
}
