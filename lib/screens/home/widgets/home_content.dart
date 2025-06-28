import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.icon,
    required this.text,
    required this.routeName,
  });
  final String icon;
  final String text;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icon/$icon.png', height: 40, fit: BoxFit.cover),
            SizedBox(height: 10),
            Text(text, maxLines: 2, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
