import 'package:flutter/material.dart';
import 'package:flutter_app/constants/app_colors.dart';
import 'package:flutter_app/constants/assets.dart';
import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/List_view_quran.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/custom_drawer.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/list_tile_view_surah.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/book_mark/book_mark_cubit.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/surah_details/surah_details_cubit.dart';
import 'package:flutter_app/features/Quran/view_quran/model/book_mark_model.dart';
import 'package:flutter_app/features/Quran/view_quran/views/book-mark_screen.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.initialAyahNumber != null) {
        Future.delayed(const Duration(milliseconds: 200), () {
          _scrollToAyah(widget.initialAyahNumber!);
        });
      }
    });
  }

  void _scrollToAyah(int ayahNumber) {
    _itemScrollController.scrollTo(
      index: ayahNumber - 1, // Adjust to 0-based index
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
                  builder: (context) => BookmarkListScreen(),
                ),
              );
            },
          )
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                right: 145,
                top: 5,
                child: Text(
                  surahName.isNotEmpty ? surahName : "جاري التحميل",
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Image.asset(
                Assets.imageBorder,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Expanded(
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) =>
                      SurahDetailCubit()..fetchSurahDetail(widget.surahNumber),
                ),
                BlocProvider(create: (context) => BookmarkCubit()),
              ],
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
                      ? ListTileViewSurah(surahDetail: surahDetail)
                      : ListViewQuran(surahDetail: surahDetail);
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
}

void onLongPress(
    BuildContext context, SurahDetail surahDetail, AyahDetail ayah) {
  showModalBottomSheet(
    context: context,
    builder: (bottomSheetContext) {
      return Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text('إضافة إلى الإشارات المرجعية'),
                onTap: () {
                  final bookmarkCubit = context.read<BookmarkCubit>();

                  // Create a bookmark object
                  final bookmark = Bookmark(
                    surahNumber: surahDetail.number,
                    ayahNumber: ayah.numberInSurah,
                    surahName: surahDetail.name,
                    ayahText: ayah.text,
                  );

                  // Add the bookmark
                  bookmarkCubit.addBookmark(bookmark);

                  // Show confirmation message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('تمت إضافة الآية إلى الإشارات المرجعية!')),
                  );

                  // Close the modal
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    },
  );
}
