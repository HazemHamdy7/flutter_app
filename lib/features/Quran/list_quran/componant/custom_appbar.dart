import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/features/choose_systom/cubit/theme_cubit/theme_cubit.dart';

AppBar customAppBar(BuildContext context) {
  final themeCubit = context.read<ThemeCubit>();
  final isDark = themeCubit.state.themeData == ThemeData.dark();

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
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color.fromARGB(255, 202, 152, 3)
                    : const Color.fromARGB(255, 202, 152, 3), // Dynamic color
                borderRadius: BorderRadius.circular(5),
              ),
              child: IconButton(
                icon: isDark
                    ? const Icon(Icons.arrow_forward_ios, color: Colors.white)
                    : Icon(Icons.arrow_back_ios,
                        color: isDark ? Colors.white : null),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
