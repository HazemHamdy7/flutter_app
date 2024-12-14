import 'dart:async'; // For Timer
import 'package:flutter/material.dart';
import 'package:flutter_app/constants/app_colors.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/custom_header.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/custom_drawer.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/helper/on_long_press.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/font_size_cubit.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/surah_details_cubit.dart';
import 'package:flutter_app/features/Quran/view_quran/views/book-mark_screen.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/helper/slider_font.dart'; // Import your custom slider

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;
  final int? initialAyahNumber;

  const SurahDetailScreen({
    super.key,
    required this.surahNumber,
    this.initialAyahNumber,
  });

  @override
  State<SurahDetailScreen> createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late ItemScrollController _itemScrollController;
  late ItemPositionsListener _itemPositionsListener;

  bool view = true;
  String currentSurahName = "";
  double fontSize = 20.0;
  int? selectedAyahIndex;
  Color selectedAyahColor = Colors.grey.shade200; // Default color
  Timer? _timer; // Timer for color change

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
    _itemPositionsListener = ItemPositionsListener.create();

    context.read<SurahDetailCubit>().fetchSurahDetail(widget.surahNumber);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialAyahNumber != null) {
        _scrollToAyah(widget.initialAyahNumber!);
      }
    });
  }

  void _scrollToAyah(int ayahNumber) {
    _itemScrollController.scrollTo(
      index: ayahNumber - 1, // Adjusting index (0-based)
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    setState(() {
      selectedAyahIndex = ayahNumber - 1;
    });
  }

  void _changeAyahColor() {
    setState(() {
      selectedAyahColor =
          Colors.yellow; // Change color to yellow or any color you prefer
    });

    _timer = Timer(const Duration(microseconds: 500), () {
      setState(() {
        selectedAyahColor = Colors.transparent; // Revert to default
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();

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
      body: Column(
        children: [
          CustomHeader(currentSurahName: currentSurahName),
          viewQuranDetalis(isDark),
          customSliderToChangFont(context),

          // Add font size slider here
        ],
      ),
    );
  }

  Expanded viewQuranDetalis(bool isDark) {
    return Expanded(
      child: BlocBuilder<SurahDetailCubit, SurahDetail?>(
        builder: (context, surahDetail) {
          if (surahDetail == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Ensure the current Surah name is loaded
          if (currentSurahName.isEmpty) {
            Future.microtask(() {
              setState(() {
                currentSurahName = surahDetail.name;
              });
            });
          }

          // Use the FontSizeCubit to get the current font size
          final fontSize = context.watch<FontSizeCubit>().state;

          return Column(
            children: [
              Expanded(
                child: ScrollablePositionedList.builder(
                  itemScrollController: _itemScrollController,
                  itemPositionsListener: _itemPositionsListener,
                  itemCount: surahDetail.ayahs.length,
                  itemBuilder: (context, index) {
                    final ayah = surahDetail.ayahs[index];
                    final String text = ayah.text;
                    final int numberInSurah = ayah.numberInSurah;

                    bool isSelected = selectedAyahIndex == index;

                    return GestureDetector(
                      onLongPress: () {
                        onLongPress(context, surahDetail, ayah);
                      },
                      onTap: () {
                        setState(() {
                          selectedAyahIndex = index;
                        });
                        _changeAyahColor(); // Change color on tap
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              fontSize: fontSize,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                            children: [
                              TextSpan(
                                text: text.trim(),
                                style: TextStyle(
                                  backgroundColor: isSelected
                                      ? selectedAyahColor
                                      : Colors.transparent, // Apply the color
                                ),
                              ),
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: Text(
                                  '﴿${numberInSurah.toString().trim().toArabicNumbers}﴾',
                                  style: TextStyle(
                                    fontFamily: 'me_quran',
                                    fontSize: fontSize,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  initialScrollIndex: widget.initialAyahNumber != null
                      ? widget.initialAyahNumber! - 1
                      : 0,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
