import 'package:flutter/material.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/screens/ideal_weight/widgets/ideal_weight_result_content.dart';

class IdealWeightResult extends StatelessWidget {
  const IdealWeightResult({super.key, required this.idealWeight});
  final double idealWeight;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Trọng lượng cơ thể lý tưởng'),
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
                  IdealWeightResultContent(idealWeight: idealWeight),
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
