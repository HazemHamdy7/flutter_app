import 'package:flutter/material.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/helper/on_long_press.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
import 'package:flutter_svg/svg.dart';

class ListTileViewSurah extends StatefulWidget {
  final SurahDetail surahDetail;
  const ListTileViewSurah({
    super.key,
    required this.surahDetail,
  });

  @override
  State<ListTileViewSurah> createState() => _ListTileViewSurahState();
}

class _ListTileViewSurahState extends State<ListTileViewSurah> {
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    double fontSize = 20.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.surahDetail.ayahs.length,
        itemBuilder: (context, index) {
          final ayah = widget.surahDetail.ayahs[index];
          final backgroundColor = index % 2 == 0
              ? (isDark ? Colors.grey[800] : Colors.grey[200])
              : (isDark ? Colors.black : Colors.white);

          return Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              title: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: fontSize,
                    color: isDark ? Colors.white : Colors.black,
                  ),
                  children: [
                    TextSpan(
                      text: ayah.text.trim(),
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: SvgPicture.asset(
                                    color: Colors.indigo,
                                    Assets.svgsNomorSurah,
                                  ),
                                ),
                                SizedBox(
                                    height: 30,
                                    width: 30,
                                    child: Center(
                                      child: Expanded(
                                        child: Text(
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          ayah.numberInSurah.toArabicNumbers,
                                        ),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () => onLongPress(context, widget.surahDetail, ayah),
            ),
          );
        },
      ),
    );
  }
}
