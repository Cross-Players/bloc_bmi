import 'package:flutter/material.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaterWave extends StatelessWidget {
  const WaterWave({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: WaveWidget(
            config: CustomConfig(
              gradients: [
                [Color(0xFF008866), Color(0xFF008866)],
                [ColorsApp.primary, ColorsApp.primary],
              ],
              durations: [5000, 8000],
              heightPercentages: [0.60, 0.62], // Lớp cao/thấp
              blur: MaskFilter.blur(BlurStyle.solid, 5),
              gradientBegin: Alignment.bottomLeft,
              gradientEnd: Alignment.topRight,
            ),
            size: const Size(double.infinity, double.infinity),
            waveAmplitude: 0,
          ),
        ),
      ],
    );
  }
}
