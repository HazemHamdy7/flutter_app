import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListViewQuran extends StatelessWidget {
  const ListViewQuran({super.key, required this.surahDetail});
  final SurahDetail surahDetail;
  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    double fontSize = 20.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
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
                          "\uFD3E${ayah.numberInSurah.toString().toArabicNumbers}\uFD3F",
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
