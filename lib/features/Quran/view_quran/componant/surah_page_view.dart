import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/surah_details_cubit.dart';
import 'package:flutter_app/features/Quran/view_quran/views/surah_detail_screen.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';

class SurahPageView extends StatefulWidget {
  final int initialSurahNumber;

  const SurahPageView({super.key, required this.initialSurahNumber});

  @override
  _SurahPageViewState createState() => _SurahPageViewState();
}

class _SurahPageViewState extends State<SurahPageView> {
  late PageController _pageController;
  double fontSize = 20.0;
  int _currentSurahNumber = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentSurahNumber = widget.initialSurahNumber;

    // Fetch the initial Surah when the widget initializes.
    context.read<SurahDetailCubit>().fetchSurahDetail(_currentSurahNumber);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _loadNextSurah() {
    setState(() {
      _currentSurahNumber++;
    });
    context.read<SurahDetailCubit>().fetchSurahDetail(_currentSurahNumber);
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    const int ayahsPerPage = 10;

    return BlocBuilder<SurahDetailCubit, SurahDetail?>(
      builder: (context, surahDetail) {
        if (surahDetail == null) {
          return const Center(child: CircularProgressIndicator());
        }

        // Clean up "Bismillah" from the first Ayah if present.
        if (surahDetail.ayahs.isNotEmpty &&
            surahDetail.ayahs[0].text.startsWith("بسم الله الرحمن الرحيم")) {
          surahDetail.ayahs[0].text = surahDetail.ayahs[0].text
              .replaceFirst("بسم الله الرحمن الرحيم", "")
              .trim();
        }

        // Create pages for Ayahs.
        final pages = List.generate(
          (surahDetail.ayahs.length / ayahsPerPage).ceil(),
          (pageIndex) {
            final start = pageIndex * ayahsPerPage;
            final end =
                (start + ayahsPerPage).clamp(0, surahDetail.ayahs.length);
            final ayahsForPage = surahDetail.ayahs.sublist(start, end);
            return ayahsForPage;
          },
        );

        return PageView.builder(
          controller: _pageController,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            final ayahs = pages[index];
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: ayahs.map((ayah) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: GestureDetector(
                        onTap: () {
                          onLongPress(context, surahDetail, ayah);
                        },
                        child: _buildAyahWidget(ayah, isDark),
                      ),
                    );
                  }).toList(),
                ),
              ),
            );
          },
          onPageChanged: (index) {
            if (index == pages.length - 1) {
              _loadNextSurah();
            }
          },
        );
      },
    );
  }
}

Widget _buildAyahWidget(AyahDetail ayah, bool isDark) {
  final String text = ayah.text;
  final int numberInSurah = ayah.numberInSurah;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Container(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            fontSize: 20,
            color: isDark ? Colors.white : Colors.black,
          ),
          children: [
            TextSpan(text: text.trim()),
            TextSpan(
              text:
                  '\uFD3F${numberInSurah.toString().trim().toArabicNumbers}\uFD3E',
              style: const TextStyle(
                fontFamily: 'me_quran',
                fontSize: 24,
                color: Colors.black, // Optional: Customize number color
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
