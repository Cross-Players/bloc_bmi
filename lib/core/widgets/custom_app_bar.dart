import 'package:flutter/material.dart';
import '../../core/colors/colors_app.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.isLeading = false});

  final String title;
  final bool isLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          isLeading
              ? null
              : IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),

      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.clip,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      leadingWidth: 30,
      backgroundColor: ColorsApp.primary,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
