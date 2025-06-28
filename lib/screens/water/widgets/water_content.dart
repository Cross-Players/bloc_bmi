import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/widgets/custom_text.dart';
import 'package:todo/screens/water/bloc/water_bloc.dart';
import 'package:todo/screens/water/bloc/water_event.dart';
import 'package:todo/screens/water/bloc/water_state.dart';
import 'package:todo/screens/water/widgets/water_choose.dart';
import 'package:todo/screens/water/widgets/water_config.dart';
import 'package:todo/screens/water/widgets/water_glass_add.dart';
import 'package:todo/screens/water/widgets/water_wave.dart';

class WaterContent extends StatelessWidget {
  const WaterContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color(0xFF00C48C).withValues(alpha: 0.15),
      ),
      child: Column(
        children: [
          Center(
            child: SizedBox(
              height: 300,
              width: 300,
              child: ClipOval(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      color: const Color(0xFF00C48C).withValues(alpha: 0.4),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: BlocBuilder<WaterBloc, WaterState>(
                        builder: (context, state) {
                          return SizedBox(
                            height: state.waveHeight,
                            child: WaterWave(),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 100,
                      child: BlocBuilder<WaterBloc, WaterState>(
                        builder: (context, state) {
                          return WaterConfig(
                            textConfig: '${state.consumedAmount}',
                            textTotal: '${state.remaining}',
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: SizedBox(
                        width: 220,
                        height: 220,
                        child: ClipPath(
                          clipper: BottomHalfCircleClipper(),
                          child: Container(color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      child: BlocBuilder<WaterBloc, WaterState>(
                        builder: (context, state) {
                          return WaterGlassAdd(
                            waterAmount: '${state.selectedAmount}ml',
                            onTap: () {
                              context.read<WaterBloc>().add(
                                AddWater(state.selectedAmount),
                              );
                              // context.read<WaterBloc>().add(ClearAllLogs());
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 60, // hoặc tùy chỉnh chiều cao phù hợp
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Center(
                  child: CustomText(text: 'Nhấn để thêm nước', isBold: true),
                ),
                Positioned(right: -20, child: WaterChoose()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomHalfCircleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.arcToPoint(
      Offset(size.width, size.height),
      radius: Radius.circular(size.width / 2),
      clockwise: true,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
