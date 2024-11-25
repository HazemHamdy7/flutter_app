import 'package:flutter/material.dart';
import 'package:flutter_app/constants/app_colors.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/custom_drawer.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/quran_view_cubit.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;
  final int? initialAyahNumber;
  final Ayah? ayah;

  const SurahDetailScreen({
    super.key,
    required this.surahNumber,
    this.initialAyahNumber,
    this.ayah,
  });

  @override
  _SurahDetailScreenState createState() => _SurahDetailScreenState();
}

class _SurahDetailScreenState extends State<SurahDetailScreen> {
  late ItemScrollController _itemScrollController;
  bool view = true;
  String surahName = "";
  double fontSize = 20.0;

  @override
  void initState() {
    super.initState();
    _itemScrollController = ItemScrollController();
    // _loadFontSize(); // Load saved font size

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialAyahNumber != null) {
        Future.delayed(const Duration(milliseconds: 200), () {
          _scrollToAyah(widget.initialAyahNumber!);
        });
      }
    });
  }

  // Future<void> _loadFontSize() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     fontSize = prefs.getDouble('fontSize') ??
  //         20.0; // Default to 20.0 if no saved size
  //   });
  // }

  // Future<void> _saveFontSize(double size) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setDouble('fontSize', size);
  // }

  void _scrollToAyah(int ayahNumber) {
    _itemScrollController.scrollTo(
      index: ayahNumber - 1,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    return Scaffold(
      backgroundColor: isDark ? AppColors.black : AppColors.white,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: isDark ? AppColors.black : AppColors.white,
        leading: Tooltip(
          message: 'Toggle View',
          child: IconButton(
            icon: SvgPicture.asset(
              Assets.svgsQuran,
            ),
            onPressed: () {
              setState(() {
                view = !view;
              });
            },
          ),
        ),
        title: Text(
          surahName.isNotEmpty ? surahName : "...جاري التحميل",
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            onPressed: () {},
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocProvider(
              create: (context) =>
                  SurahDetailCubit()..fetchSurahDetail(widget.surahNumber),
              child: BlocBuilder<SurahDetailCubit, SurahDetail?>(
                builder: (context, surahDetail) {
                  if (surahDetail == null) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (surahName.isEmpty) {
                    Future.microtask(() {
                      setState(() {
                        surahName = surahDetail.name;
                      });
                    });
                  }

                  return view
                      ? _buildFullView(surahDetail)
                      : _buildListTileView(surahDetail);
                },
              ),
            ),
          ),
          customSliderToChangFont(),
        ],
      ),
    );
  }

  Padding customSliderToChangFont() {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "الحجم:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: isDark ? AppColors.white : AppColors.black,
            ),
          ),
          Expanded(
            child: Slider(
              divisions: 20,
              activeColor: Colors.green,
              min: 16.0,
              max: 36.0,
              value: fontSize,
              onChanged: (newSize) {
                setState(() {
                  fontSize = newSize;
                });
                // _saveFontSize(newSize);
              },
            ),
          ),
          Text(
            fontSize.toInt().toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
              color: isDark ? AppColors.white : AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullView(SurahDetail surahDetail) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    const int ayahsPerPage = 10;

    final pages = List.generate(
      (surahDetail.ayahs.length / ayahsPerPage).ceil(),
      (pageIndex) {
        final start = pageIndex * ayahsPerPage;
        final end = (start + ayahsPerPage).clamp(0, surahDetail.ayahs.length);
        final ayahsForPage = surahDetail.ayahs.sublist(start, end);

        return ayahsForPage;
      },
    );

    return PageView.builder(
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
                    onTap: () => _onLongPress(context, surahDetail, ayah),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: fontSize,
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
    );
  }

  Widget _buildListTileView(SurahDetail surahDetail) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: surahDetail.ayahs.length,
        itemBuilder: (context, index) {
          final ayah = surahDetail.ayahs[index];
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
                      color: isDark ? Colors.white : Colors.black),
                  children: [
                    TextSpan(text: ayah.text.trim()),
                    TextSpan(
                      text:
                          '\uFD3F${ayah.numberInSurah.toString().toArabicNumbers}\uFD3E',
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'me_quran'),
                    ),
                  ],
                ),
              ),
              onTap: () => _onLongPress(context, surahDetail, ayah),
            ),
          );
        },
      ),
    );
  }
}

void _onLongPress(
    BuildContext context, SurahDetail surahDetail, AyahDetail ayah) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              trailing: const Icon(Icons.bookmark),
              title: const Text(
                textAlign: TextAlign.end,
                'أضافة آشاره مرجعية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                // final bookmark = Bookmark(
                //   surahNumber: surahDetail.number,
                //   ayahNumber: ayah.numberInSurah,
                //   surahName: surahDetail.name,
                //   ayahText: ayah.text,
                // );

                // context.read<BookmarkCubit>().addBookmark(bookmark);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      backgroundColor: Colors.indigoAccent,
                      content: Text(
                        'تمت اضافة الآية المرجعية للمفضلة',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )),
                );
                Navigator.pop(context); // Close the modal sheet
              },
            ),
            ListTile(
              trailing: const Icon(Icons.menu_book_sharp),
              title: const Text(
                textAlign: TextAlign.end,
                'تفسير',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {
                // Add bookmark
              },
            ),
            ListTile(
              trailing: const Icon(Icons.music_note),
              title: const Text(
                textAlign: TextAlign.end,
                'استماع',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              onTap: () {},
            ),
            // Add more options here if needed
          ],
        ),
      );
    },
  );
}
