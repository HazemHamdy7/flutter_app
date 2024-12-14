import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.currentSurahName});

  final String currentSurahName;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 145,
          top: 5,
          child: Text(
            currentSurahName.isNotEmpty ? currentSurahName : "جاري التحميل",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Image.asset(
          Assets.imageBorder,
          fit: BoxFit.cover,
        ),
      ],
    );
  }
}
