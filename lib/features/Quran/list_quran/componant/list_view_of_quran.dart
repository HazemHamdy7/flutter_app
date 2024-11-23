import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/features/Quran/view_quran/views/surah_detail_screen.dart';
import 'package:flutter_app/features/choose_systom/cubit/theme_cubit/theme_cubit.dart';

class ListViewOfQuran extends StatelessWidget {
  const ListViewOfQuran({super.key, required this.surahs});

  final List surahs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeData == ThemeData.dark();
        final backgroundColor = isDark ? Colors.black : Colors.grey[200];
        final textColor = isDark ? Colors.white : Colors.black;

        return ListView.builder(
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final surah = surahs[index];
            final rowBackgroundColor = index % 2 == 0
                ? backgroundColor
                : (isDark ? Colors.grey[800] : Colors.white);

            return Container(
              color: rowBackgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${surah.number} - ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: textColor,
                                ),
                              ),
                              Text(
                                surah.name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontFamily: "me_quran",
                                  color: textColor,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            surah.englishName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "me_quran",
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        textAlign: TextAlign.end,
                        ' ${surah.ayahsCount} - أيــة: ${surah.revelationType} ',
                        style: TextStyle(color: textColor),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SurahDetailScreen(
                          surahNumber: surah.number,
                          initialAyahNumber: 1,
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
