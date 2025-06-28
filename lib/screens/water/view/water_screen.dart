import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/screens/water/bloc/water_bloc.dart';
import 'package:todo/screens/water/bloc/water_event.dart';
import 'package:todo/screens/water/widgets/water_content.dart';
import 'package:todo/screens/water/widgets/water_line.dart';
import 'package:todo/screens/water/widgets/water_record.dart';

class WaterScreen extends StatelessWidget {
  const WaterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create:
          (_) =>
              WaterBloc()
                ..add(LoadInitialAmount())
                ..add(LoadTodayLogs()),
      child: Scaffold(
        appBar: CustomAppBar(title: 'Lượng nước uống mỗi ngày'),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 20),
                WaterLine(),
                SizedBox(height: 30),
                Text(
                  'Hãy uống một chút nước!',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                WaterContent(),
                SizedBox(height: 20),
                WaterRecord(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
