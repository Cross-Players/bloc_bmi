import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/screens/calorie/model/activity_level.dart';
import 'package:todo/screens/calorie/widgets/calorie_card.dart';

class CalorieResult extends StatelessWidget {
  const CalorieResult({
    super.key,
    required this.tdee,
    required this.activityLevel,
  });
  final double tdee;
  final ActivityLevel activityLevel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Lượng calo hàng ngày'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 100),
              Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.topCenter,
                children: [
                  CalorieCard(tdee: tdee, activityLevel: activityLevel),

                  Positioned(
                    top: -40,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(
                              0,
                              3,
                            ), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Image.asset(
                        'assets/icon/check.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
