import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/view_quran/views/surah_detail_screen.dart';

class ListViewOfQuran extends StatelessWidget {
  const ListViewOfQuran({super.key, required this.surahs});

  final List surahs;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: surahs.length,
      itemBuilder: (context, index) {
        final surah = surahs[index];
        final backgroundColor =
            index % 2 == 0 ? Colors.grey[200] : Colors.white;
        return Container(
          color: backgroundColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8.0),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                // side: const BorderSide(color: Colors.grey, width: 0.5),
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
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            surah.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontFamily: "me_quran",
                            ),
                          ),
                        ],
                      ),
                      Text(
                        surah.englishName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: "me_quran",
                        ),
                      ),
                    ],
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    ' ${surah.ayahsCount} - أيــة: ${surah.revelationType} ',
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
  }
}
