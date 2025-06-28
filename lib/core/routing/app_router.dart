import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/core/widgets/custom_result_screen.dart';
import 'package:todo/screens/bmr/view/bmr_result.dart';
import 'package:todo/screens/bmr/view/bmr_screen.dart';
import 'package:todo/screens/body_fat/view/body_fat_screen.dart';
import 'package:todo/screens/body_frame/view/body_frame_screen.dart';
import 'package:todo/screens/calorie/view/calorie_result.dart';
import 'package:todo/screens/calorie/view/calorie_screen.dart';
import 'package:todo/screens/calories_burned/view/calories_burned_result.dart';
import 'package:todo/screens/calories_burned/view/calories_burned_screen.dart';
import 'package:todo/screens/chest_hip/view/chest_hip_screen.dart';
import 'package:todo/screens/home/view/home_screen.dart';
import 'package:todo/screens/ideal_weight/view/ideal_weight_result.dart';
import 'package:todo/screens/ideal_weight/view/ideal_weight_screen.dart';
import 'package:todo/screens/lean_muscle/view/lean_muscle_screen.dart';
import 'package:todo/screens/mass/bloc/mass_bloc.dart';
import 'package:todo/screens/mass/view/mass_result_screen.dart';
import 'package:todo/screens/mass/view/mass_screen.dart';
import 'package:todo/screens/roots/view/root_screen.dart';
import 'package:todo/screens/setting/view/setting_screen.dart';
import 'package:todo/screens/waist_height/view/waist_height_screen.dart';
import 'package:todo/screens/waist_hip/view/waist_hip_screen.dart';
import 'package:todo/screens/water/view/water_screen.dart';
import 'package:todo/screens/weight/view/weight_screen.dart';
import 'package:todo/screens/weight/widgets/weight_celebartion.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );

      case RouteName.weight:
        return MaterialPageRoute(
          builder: (_) => const WeightScreen(),
          settings: settings,
        );
      case RouteName.congraScreen:
        return MaterialPageRoute(
          builder: (_) => const WeightCelebration(),
          settings: settings,
        );
      case RouteName.setting:
        return MaterialPageRoute(
          builder: (_) => const SettingScreen(),
          settings: settings,
        );
      case RouteName.root:
        return MaterialPageRoute(
          builder: (_) => const RootScreen(),
          settings: settings,
        );
      case RouteName.mass:
        return MaterialPageRoute(
          builder:
              (_) => BlocProvider(
                create: (_) => MassBloc(),
                child: const MassScreen(),
              ),
        );
      case RouteName.massResult:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => MassResultScreen(
                bmi: args['bmi'],
                category: args['category'],
              ),
        );
      case RouteName.weightResult:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => IdealWeightResult(idealWeight: args['idealWeight']),
        );
      case RouteName.customResultScreen:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => CustomResultScreen(
                result: args['result'],
                title: args['title'],
                content: args['content'],
              ),
        );
      case RouteName.bmrResult:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => BmrResult(bmr: args['bmr']));
      case RouteName.idealWeight:
        return MaterialPageRoute(
          builder: (_) => const IdealWeightScreen(),
          settings: settings,
        );
      case RouteName.chestHipScreen:
        return MaterialPageRoute(
          builder: (_) => const ChestHipScreen(),
          settings: settings,
        );
      case RouteName.waistHeightScreen:
        return MaterialPageRoute(
          builder: (_) => const WaistHeightScreen(),
          settings: settings,
        );
      case RouteName.waistHipScreen:
        return MaterialPageRoute(
          builder: (_) => const WaistHipScreen(),
          settings: settings,
        );
      case RouteName.bodyFatScreen:
        return MaterialPageRoute(
          builder: (_) => const BodyFatScreen(),
          settings: settings,
        );
      case RouteName.bodyFrameScreen:
        return MaterialPageRoute(
          builder: (_) => const BodyFrameScreen(),
          settings: settings,
        );
      case RouteName.calorieBurned:
        return MaterialPageRoute(
          builder: (_) => const CaloriesBurnedScreen(),
          settings: settings,
        );
      case RouteName.leanMuscleScreen:
        return MaterialPageRoute(
          builder: (_) => const LeanMuscleScreen(),
          settings: settings,
        );
      case RouteName.calorieBurnedResult:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CaloriesBurnedResult(calories: args['calories']),
        );
      case RouteName.calorieScreen:
        return MaterialPageRoute(
          builder: (_) => const CalorieScreen(),
          settings: settings,
        );
      case RouteName.waterScreen:
        return MaterialPageRoute(
          builder: (_) => const WaterScreen(),
          settings: settings,
        );
      case RouteName.calorieResult:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder:
              (_) => CalorieResult(
                tdee: args['tdee'],
                activityLevel: args['activityLevel'],
              ),
        );
      case RouteName.bmrScreen:
        return MaterialPageRoute(
          builder: (_) => const BmrScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder:
              (_) => const Scaffold(
                body: Center(child: Text('404 - Trang không tồn tại')),
              ),
        );
    }
  }
}
