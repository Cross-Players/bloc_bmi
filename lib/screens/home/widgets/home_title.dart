import 'package:flutter/material.dart';
import 'package:todo/core/routing/route_name.dart';
import 'package:todo/screens/home/widgets/home_content.dart';

class HomeTitle extends StatelessWidget {
  const HomeTitle({super.key});

  List<String> get content => [
    'Chỉ số khối cơ thể',
    'Trọng lượng cơ thể lý tưởng',
    'Trao đổi chất cơ bản',
    'Lượng calo hàng ngày',
    'Calo bị đốt cháy',
    'Lượng nước uống hàng ngày',
    'Khối lượng cơ nạc',
    'Kích thước khung cơ thể',
    'Mỡ cơ thể',
    'Tỉ lệ ngực hông',
    'Tỉ lệ vòng eo và chiều cao',
    'Tỉ lệ eo hông',
  ];
  List<String> get icon => [
    'human',
    'scale',
    'heart',
    'calo',
    'sport',
    'water',
    'builder',
    'expand',
    'fat',
    'body',
    'height',
    'waist',
  ];
  List<String> get route => [
    RouteName.mass,
    RouteName.idealWeight,
    RouteName.bmrScreen,
    RouteName.calorieScreen,
    RouteName.calorieBurned,
    RouteName.waterScreen,
    RouteName.leanMuscleScreen,
    RouteName.bodyFrameScreen,
    RouteName.bodyFatScreen,
    RouteName.chestHipScreen,
    RouteName.waistHeightScreen,
    RouteName.waistHipScreen,
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 20.0,
      ),
      itemCount: 12,
      itemBuilder: (BuildContext context, int index) {
        return HomeContent(
          text: content[index],
          icon: icon[index],
          routeName: route[index],
        );
      },
    );
  }
}
