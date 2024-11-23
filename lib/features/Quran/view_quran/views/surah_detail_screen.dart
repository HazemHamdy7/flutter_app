import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/Quran/view_quran/componant/retun_basmala.dart';
import 'package:flutter_app/features/Quran/view_quran/cubit/quran_view_cubit.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class SurahDetailScreen extends StatefulWidget {
  final int surahNumber;
  final int? initialAyahNumber;

  const SurahDetailScreen({
    super.key,
    required this.surahNumber,
    this.initialAyahNumber,
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Tooltip(
          message: 'Toggle View',
          child: IconButton(
            icon: const Icon(Icons.chrome_reader_mode),
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
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const BookmarkScreen()),
              // );
            },
          ),
        ],
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Slider for font size

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "الحجم:",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
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
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFullView(SurahDetail surahDetail) {
    return ScrollablePositionedList.builder(
      itemScrollController: _itemScrollController,
      itemCount: surahDetail.ayahs.length + 1,
      itemBuilder: (context, index) {
        // Skip the Basmala for Surah 9 or -1 (handle special case)
        if (index == 0 && widget.surahNumber != -1 && widget.surahNumber != 9) {
          return const RetunBasmala(); // Display Basmala
        } else if (index == surahDetail.ayahs.length + 1) {
          return const Divider();
        }

        final ayahIndex = widget.surahNumber != 1 && widget.surahNumber != 9
            ? index - 1
            : index;

        if (ayahIndex < 0 || ayahIndex >= surahDetail.ayahs.length) {
          return const SizedBox.shrink();
        }

        final ayah = surahDetail.ayahs[ayahIndex];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: GestureDetector(
            onTap: () => _onLongPress(context, surahDetail, ayah),
            child: RichText(
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              text: TextSpan(
                style: TextStyle(fontSize: fontSize, color: Colors.black),
                children: [
                  TextSpan(text: ayah.text.trim()),
                  TextSpan(
                    text:
                        ' \uFD3F${(ayahIndex + 1).toString().toArabicNumbers}\uFD3E',
                    style:
                        const TextStyle(fontFamily: 'me_quran', fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListTileView(SurahDetail surahDetail) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: surahDetail.ayahs.map((ayah) {
            return ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
              title: RichText(
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  style: TextStyle(fontSize: fontSize, color: Colors.black),
                  children: [
                    TextSpan(
                      text: ayah.text.trim(),
                    ),
                    TextSpan(
                        text:
                            '\uFD3F${ayah.numberInSurah.toString().toArabicNumbers}\uFD3E',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'me_quran')),
                  ],
                ),
              ),
              onTap: () => _onLongPress(context, surahDetail, ayah),
            );
          }).toList(),
        ),
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
