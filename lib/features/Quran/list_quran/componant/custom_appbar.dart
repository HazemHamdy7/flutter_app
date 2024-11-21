import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_svg/svg.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    centerTitle: true,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          S.of(context).Fuhras,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {
                // Handle search icon tap
              },
            ),
            IconButton(
              icon: SvgPicture.asset(
                Assets.svgsSearchIcon,
              ),
              onPressed: () {},
            ),
          ],
        )
      ],
    ),
    backgroundColor: const Color.fromARGB(255, 233, 228, 213),
    bottom: TabBar(
      splashBorderRadius: BorderRadius.circular(50),
      indicatorSize: TabBarIndicatorSize.tab,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      indicatorColor: Colors.indigo,
      tabs: [
        Tab(text: S.of(context).surah),
        Tab(text: S.of(context).parts),
      ],
    ),
  );
}
