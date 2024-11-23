import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/features/choose_language/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';

AppBar customAppBar(BuildContext context) {
  final themeCubit = context.read<ThemeCubit>();
  final isDark = themeCubit.state.themeData == ThemeData.dark();
  final Locale locale = context.read<LanguageCubit>().state;

  return AppBar(
    centerTitle: true,
    automaticallyImplyLeading: true,

    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).Fuhras,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.amber,
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  Assets.svgsSearchIcon,
                  color: isDark ? Colors.white : Colors.black,
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                      isDark ? Colors.grey[800]! : Colors.amber),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )),
              icon: locale.languageCode == 'ar'
                  ? Icon(Icons.arrow_forward_ios,
                      color: isDark ? Colors.white : Colors.black)
                  : Icon(Icons.arrow_back_ios,
                      color: isDark ? Colors.white : Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        )
      ],
    ),
    backgroundColor: isDark
        ? Colors.black
        : const Color.fromARGB(255, 233, 228, 213), // Dynamic background
    bottom: TabBar(
      splashBorderRadius: BorderRadius.circular(50),
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      labelColor: isDark
          ? Colors.amber
          : const Color.fromARGB(255, 223, 169, 7), // Dynamic label color
      unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey,
      indicatorColor:
          isDark ? Colors.amber : Colors.indigo, // Dynamic indicator color
      tabs: [
        Tab(text: S.of(context).surah),
        Tab(text: S.of(context).parts),
      ],
    ),
  );
}
