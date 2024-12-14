import 'package:flutter/material.dart';
import 'package:flutter_app/constants/app_colors.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/custom_drawer.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/helper/on_long_press.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/surah_details_cubit.dart';
import 'package:flutter_app/features/Quran/view_quran/views/book-mark_screen.dart';
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
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentSurahNumber = widget.initialSurahNumber;

    // Fetch Surah only once.
    _fetchSurah();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _fetchSurah() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
      });
      context.read<SurahDetailCubit>().fetchSurahDetail(_currentSurahNumber);
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  void _loadNextSurah() {
    if (_currentSurahNumber < 114) {
      setState(() {
        _currentSurahNumber++;
      });
      _fetchSurah();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You have reached the last surah.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    const int ayahsPerPage = 10;

    return BlocBuilder<SurahDetailCubit, SurahDetail?>(
      builder: (context, surahDetail) {
        if (_isLoading || surahDetail == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final ayahs = surahDetail.ayahs;

        // Create pages for Ayahs.
        final pages = List.generate(
          (ayahs.length / ayahsPerPage).ceil(),
          (pageIndex) {
            final start = pageIndex * ayahsPerPage;
            final end = (start + ayahsPerPage).clamp(0, ayahs.length);
            return ayahs.sublist(start, end);
          },
        );

        return Scaffold(
          backgroundColor: isDark ? AppColors.black : AppColors.white,
          drawer: const CustomDrawer(),
          appBar: AppBar(
            backgroundColor: isDark ? AppColors.black : AppColors.white,
            actions: [
              IconButton(
                icon: const Icon(Icons.bookmark),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BookmarkListScreen(),
                    ),
                  );
                },
              )
            ],
            centerTitle: true,
          ),
          body: PageView.builder(
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
          ),
        );
      },
    );
  }
}

Widget _buildAyahWidget(AyahDetail ayah, bool isDark) {
  final String text = ayah.text;
  final int numberInSurah = ayah.numberInSurah;
  double fontSize = 20.0;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          color: isDark ? Colors.white : Colors.black,
        ),
        children: [
          TextSpan(text: text.trim()),
          WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Text(
                '﴿${numberInSurah.toString().trim().toArabicNumbers}﴾',
                style: const TextStyle(
                  fontFamily: 'me_quran',
                  fontSize: 24,
                  color: Colors.black, // Optional: Customize number color
                ),
              ))
        ],
      ),
    ),
  );
}
