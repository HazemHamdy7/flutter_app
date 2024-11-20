import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/componant/app_colors.dart';
import 'package:flutter_app/features/Quran/list_quran/componant/custom_text.dart';
import 'package:flutter_svg/flutter_svg.dart';
 

AppBar customAppBar(BuildContext context) => AppBar(
      centerTitle: true,
      backgroundColor: AppColors.background.withOpacity(0.7),
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // IconButton(
          //   onPressed: () {
          //     // Navigator.of(context).push(
          //     //     MaterialPageRoute(builder: (context) => const Settings()));
          //   },
          //   icon: SvgPicture.asset(Assets.svgsMenuIcon),
          //   color: Colors.white,
          // ),
          CustomText(
              text: "القران الكريم",
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white),
          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.bookmarks),
          //   color: Colors.white,
          //   isSelected: true,
          //   style: IconButton.styleFrom(),
          // ),
        ],
      ),
    );
