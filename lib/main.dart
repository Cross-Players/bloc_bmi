import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/routing/app_router.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/screens/roots/bloc/navigation_cubit.dart';
import 'package:todo/screens/weight/bloc/weight_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(create: (context) => NavigationCubit()),
        BlocProvider<WeightBloc>(create: (context) => WeightBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: RouteName.root,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
