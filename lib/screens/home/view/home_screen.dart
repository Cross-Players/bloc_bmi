import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/screens/home/widgets/home_card.dart';
import 'package:todo/screens/home/widgets/home_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Home',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leadingWidth: 100,
        backgroundColor: ColorsApp.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              HomeCard(),
              SizedBox(height: 20),
              HomeTitle(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
