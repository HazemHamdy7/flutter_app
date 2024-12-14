import 'package:flutter/material.dart';
import 'package:flutter_app/constants/app_colors.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/font_size_cubit.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Padding customSliderToChangFont(BuildContext context) {
  final themeCubit = context.read<ThemeCubit>();
  final fontSize = context.select(
      (FontSizeCubit cubit) => cubit.state); // This will optimize performance

  final isDark = themeCubit.state.themeData == ThemeData.dark();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "الحجم:",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        Expanded(
          child: Slider(
            divisions: 20,
            activeColor: Colors.green,
            min: 16.0,
            max: 36.0,
            value: fontSize,
            onChanged: (newSize) {
              context.read<FontSizeCubit>().setFontSize(newSize);
            },
          ),
        ),
        Text(
          fontSize.toInt().toString(),
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
      ],
    ),
  );
}
