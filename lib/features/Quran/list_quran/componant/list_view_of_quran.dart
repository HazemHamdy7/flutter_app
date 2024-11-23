import 'package:flutter/material.dart';
import 'package:flutter_app/features/choose_language/cubits/language_cubit/language_cubit.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/utils/helper/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/features/Quran/view_quran/views/surah_detail_screen.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';

class ListViewOfQuran extends StatelessWidget {
  const ListViewOfQuran({super.key, required this.surahs});

  final List surahs;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final isDark = state.themeData == ThemeData.dark();
        final backgroundColor = isDark ? AppColors.black : Colors.grey[200];
        final textColor = isDark ? AppColors.white : AppColors.black;
        final Locale locale = context.read<LanguageCubit>().state;

        return ListView.builder(
          itemCount: surahs.length,
          itemBuilder: (context, index) {
            final surah = surahs[index];
            final rowBackgroundColor = index % 2 == 0
                ? backgroundColor
                : (isDark ? Colors.grey[600] : AppColors.white);

            return Container(
              color: isDark ? AppColors.black : rowBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 3.0),
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
                              fontSize: 14,
                              fontFamily: "me_quran",
                              color: textColor,
                            ),
                          ),
                          Text(
                            textAlign: TextAlign.end,
                            '${surah.revelationType == 'Meccan' ? S.of(context).Meccan : S.of(context).Madinan} - ${S.of(context).ayah}: ${surah.ayahsCount}',
                            style: TextStyle(color: textColor, fontSize: 12),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Text(
                        textAlign: TextAlign.end,
                        ' ${S.of(context).page}: ${surah.ayahsCount} ',
                        style: TextStyle(color: textColor, fontSize: 12),
                      ),
                      IconButton(
                        style: ButtonStyle(
                            backgroundColor: WidgetStateProperty.all<Color>(
                                isDark ? Colors.grey[800]! : Colors.amber),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            )),
                        icon: locale.languageCode == 'ar'
                            ? Icon(Icons.arrow_forward_ios,
                                color:
                                    isDark ? AppColors.white : AppColors.black)
                            : Icon(Icons.arrow_back_ios,
                                color:
                                    isDark ? AppColors.white : AppColors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
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
