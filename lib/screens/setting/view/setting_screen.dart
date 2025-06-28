import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/widgets/custom_app_bar.dart';
import 'package:todo/screens/setting/widgets/setting_card.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Giới thiệu', isLeading: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              SettingCard(
                icon: FontAwesomeIcons.bolt,
                title: "Tăng cường sức khỏe",
                subtitle: "Theo dõi cân nặng và chạm tới mục tiêu mỗi ngày!",
              ),
              SizedBox(height: 20),
              SettingCard(
                icon: FontAwesomeIcons.chartLine,
                title: "Biểu đồ tiến trình",
                subtitle:
                    "Xem lại thay đổi cân nặng mỗi ngày một cách trực quan.",
              ),
              SizedBox(height: 20),
              SettingCard(
                icon: FontAwesomeIcons.bullseye,
                title: "Mục tiêu rõ ràng",
                subtitle:
                    "Thiết lập cân nặng mong muốn và bám sát kế hoạch cá nhân.",
              ),
              SizedBox(height: 20),
              SettingCard(
                icon: FontAwesomeIcons.bell,
                title: "Nhắc nhở thông minh",
                subtitle:
                    "Đừng quên cập nhật cân nặng thường xuyên với thông báo nhẹ nhàng.",
              ),
              SizedBox(height: 20),
              SettingCard(
                icon: FontAwesomeIcons.trophy,
                title: "Chúc mừng thành tích",
                subtitle:
                    "Pháo hoa sẽ nổ tung khi bạn chạm đến mục tiêu đề ra!",
              ),
              SizedBox(height: 20),
              SettingCard(
                icon: FontAwesomeIcons.shieldHeart,
                title: "Sức khỏe là ưu tiên",
                subtitle:
                    "Ứng dụng đồng hành cùng bạn trong hành trình cải thiện thể trạng.",
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
