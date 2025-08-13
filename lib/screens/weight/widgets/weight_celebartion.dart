import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/screens/weight/bloc/weight_bloc.dart';
import 'package:todo/screens/weight/bloc/weight_event.dart';

class WeightCelebration extends StatefulWidget {
  const WeightCelebration({super.key});

  @override
  State<WeightCelebration> createState() => _WeightCelebrationState();
}

class _WeightCelebrationState extends State<WeightCelebration> {
  late ConfettiController _topController;
  late ConfettiController _bottomController;
  late ConfettiController _centerController;

  @override
  void initState() {
    super.initState();
    _topController = ConfettiController(duration: const Duration(seconds: 5));
    _bottomController = ConfettiController(
      duration: const Duration(seconds: 5),
    );
    _centerController = ConfettiController(
      duration: const Duration(seconds: 5),
    );
    _topController.play();
    _bottomController.play();
    _centerController.play();
  }

  @override
  void dispose() {
    _topController.dispose();
    _bottomController.dispose();
    _centerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorsApp.primary.withValues(alpha: 1.1),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '🎯 Chúc mừng!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Bạn đã đạt được mục tiêu !!!',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 40),
                  GestureDetector(
                    onTap: () {
                      context.read<WeightBloc>().add(ClearAllWeightData());
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Text(
                        'Hãy tiếp tục với mục tiêu tiếp theo nào !!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: ColorsApp.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 50,
          right: 20,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.close, size: 30, color: Colors.white),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _topController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            maxBlastForce: 30,
            minBlastForce: 10,
            emissionFrequency: 0.08,
            numberOfParticles: 40,
            gravity: 0.2,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ConfettiWidget(
            confettiController: _bottomController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            maxBlastForce: 25,
            minBlastForce: 5,
            emissionFrequency: 0.06,
            numberOfParticles: 35,
            gravity: 0.3,
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _centerController,
            blastDirectionality: BlastDirectionality.explosive,
            shouldLoop: false,
            maxBlastForce: 20,
            minBlastForce: 5,
            emissionFrequency: 0.05,
            numberOfParticles: 25,
            gravity: 0.1,
          ),
        ),
      ],
    );
  }
}
