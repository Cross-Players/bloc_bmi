import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/core/colors/colors_app.dart';
import 'package:todo/screens/home/view/home_screen.dart';
import 'package:todo/screens/roots/bloc/navigation_cubit.dart';
import 'package:todo/screens/setting/view/setting_screen.dart';
import 'package:todo/screens/weight/view/weight_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  List<Widget> get screens => [
    const HomeScreen(),
    const WeightScreen(),
    const SettingScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: IndexedStack(index: currentIndex, children: [...screens]),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, -1), // Shadow phía trên
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),

              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                currentIndex: currentIndex,
                onTap:
                    (index) =>
                        context.read<NavigationCubit>().changeIndex(index),
                selectedItemColor: ColorsApp.primary,
                unselectedItemColor: Colors.grey,
                selectedLabelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: const TextStyle(fontSize: 16),
                items: [
                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.house, size: 30),
                    label: 'Nhà',
                  ),

                  BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.weightScale, size: 30),
                    label: 'Cân nặng',
                  ),
                  BottomNavigationBarItem(
                    icon: CircleAvatar(
                      radius: 15,
                      backgroundColor:
                          currentIndex == 2 ? ColorsApp.primary : Colors.grey,
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    label: 'Thêm',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
