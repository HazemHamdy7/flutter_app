import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/Quran/view_quran/views/surah_detail_screen.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurahPageView extends StatefulWidget {
  final SurahDetail surahDetail;

  const SurahPageView({super.key, required this.surahDetail});

  @override
  _SurahPageViewState createState() => _SurahPageViewState();
}

class _SurahPageViewState extends State<SurahPageView> {
  late PageController _pageController;
  double fontSize = 20.0;
  SurahDetail? _currentSurahDetail;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentSurahDetail = widget.surahDetail;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    const int ayahsPerPage = 10;

    // Remove "بسم الله الرحمن الرحيم" from the first ayah if it exists
    if (_currentSurahDetail!.ayahs.isNotEmpty &&
        _currentSurahDetail!.ayahs[0].text
            .startsWith("بسم الله الرحمن الرحيم")) {
      _currentSurahDetail!.ayahs[0].text = _currentSurahDetail!.ayahs[0].text
          .replaceFirst("بسم الله الرحمن الرحيم", "")
          .trim();
    }

    final pages = List.generate(
      (_currentSurahDetail!.ayahs.length / ayahsPerPage).ceil(),
      (pageIndex) {
        final start = pageIndex * ayahsPerPage;
        final end =
            (start + ayahsPerPage).clamp(0, _currentSurahDetail!.ayahs.length);
        final ayahsForPage = _currentSurahDetail!.ayahs.sublist(start, end);

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
                    onTap: () =>
                        onLongPress(context, _currentSurahDetail!, ayah),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                        children: [
                          TextSpan(text: ayah.text.trim()),
                          TextSpan(
                            text:
                                '\uFD3F${ayah.numberInSurah.toString().trim().toArabicNumbers}\uFD3E',
                            style: const TextStyle(
                              fontFamily: 'me_quran',
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
      onPageChanged: (index) {
        if (index == pages.length - 1) {
          // Load next Surah when the last page is reached
          _loadNextSurah();
        }
      },
    );
  }

  void _loadNextSurah() async {
    // Fetch the next Surah's details
    final nextSurahDetail =
        await fetchNextSurahDetail(_currentSurahDetail!.number + 1);

    // Update the state with the new Surah details
    setState(() {
      _currentSurahDetail = nextSurahDetail;
      _pageController.jumpToPage(0); // Reset to the first page of the new Surah
    });
  }

  Future<SurahDetail> fetchNextSurahDetail(int surahNumber) async {
    // Implement your logic to fetch the next Surah's details
    // This could be an API call or fetching from a local database
    // For example:
    final response =
        await Dio().get('https://api.example.com/surah/$surahNumber');
    if (response.statusCode == 200) {
      return SurahDetail.fromJson(json.decode(response.data));
    } else {
      throw Exception('Failed to load Surah');
    }
  }
}
