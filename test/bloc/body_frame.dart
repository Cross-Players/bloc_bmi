import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:todo/screens/body_frame/bloc/body_frame_state.dart';
import 'package:todo/screens/body_frame/bloc/body_frame_cubit.dart';

void main() {
  group('BodyFrameCubit', () {
    late BodyFrameCubit cubit;

    setUp(() {
      cubit = BodyFrameCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is BodyFrameState', () {
      expect(cubit.state, const BodyFrameState());
    });

    blocTest<BodyFrameCubit, BodyFrameState>(
      'emits state with gender updated',
      build: () => BodyFrameCubit(),
      act: (cubit) => cubit.setGender(Gender.female),
      expect: () => [const BodyFrameState(gender: Gender.female)],
    );

    blocTest<BodyFrameCubit, BodyFrameState>(
      'emits state with height unit updated',
      build: () => BodyFrameCubit(),
      act: (cubit) => cubit.setHeightUnit(HeightUnit.feetInch),
      expect: () => [const BodyFrameState(heightUnit: HeightUnit.feetInch)],
    );

    blocTest<BodyFrameCubit, BodyFrameState>(
      'emits state with wrist unit updated',
      build: () => BodyFrameCubit(),
      act: (cubit) => cubit.setWristUnit(WristUnit.inch),
      expect: () => [const BodyFrameState(wristUnit: WristUnit.inch)],
    );

    blocTest<BodyFrameCubit, BodyFrameState>(
      'calculates frame size for male - Small',
      build: () {
        final cubit = BodyFrameCubit();
        cubit.setGender(Gender.male);
        cubit.setHeightUnit(HeightUnit.cm);
        cubit.setWristUnit(WristUnit.cm);
        return cubit;
      },
      act:
          (cubit) => cubit.calculateFrameSize(
            height1: '180',
            height2: '',
            wristText: '17',
          ),
      expect:
          () => [
            isA<BodyFrameState>()
                .having((s) => s.ratio, 'ratio', closeTo(10.588, 0.01))
                .having((s) => s.frameSize, 'frameSize', 'Nhỏ'),
          ],
    );

    blocTest<BodyFrameCubit, BodyFrameState>(
      'calculates frame size for female - Trung bình',
      build: () {
        final cubit = BodyFrameCubit();
        cubit.setGender(Gender.female);
        cubit.setHeightUnit(HeightUnit.cm);
        cubit.setWristUnit(WristUnit.cm);
        return cubit;
      },
      act:
          (cubit) => cubit.calculateFrameSize(
            height1: '160',
            height2: '',
            wristText: '15.5',
          ),
      expect:
          () => [
            isA<BodyFrameState>()
                .having((s) => s.ratio, 'ratio', closeTo(10.322, 0.01))
                .having((s) => s.frameSize, 'frameSize', 'Trung bình'),
          ],
    );

    blocTest<BodyFrameCubit, BodyFrameState>(
      'emits null frameSize when height or wrist is zero',
      build: () => BodyFrameCubit(),
      seed:
          () => const BodyFrameState(
            gender: Gender.male,
            heightUnit: HeightUnit.cm,
            wristUnit: WristUnit.cm,
            frameSize: 'Trung bình',
            ratio: 10.2,
          ),
      act:
          (cubit) =>
              cubit.calculateFrameSize(height1: '', height2: '', wristText: ''),
      expect:
          () => [
            const BodyFrameState(
              gender: Gender.male,
              heightUnit: HeightUnit.cm,
              wristUnit: WristUnit.cm,
              frameSize: null,
              ratio: null,
            ),
          ],
    );
  });
}
