import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_app/features/choose_system/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
 
class ListViewQuran extends StatefulWidget {
  const ListViewQuran({super.key, required this.surahDetail});
  final SurahDetail surahDetail;

  @override
  _ListViewQuranState createState() => _ListViewQuranState();
}

class _ListViewQuranState extends State<ListViewQuran> {
  // final AudioPlayer _audioPlayer = AudioPlayer(); // Audio player instance
  // int? _playingAyahIndex; // Track the currently playing Ayah

  // @override
  // void dispose() {
  //   _audioPlayer.dispose(); // Dispose the audio player
  //   super.dispose();
  // }

  // Future<void> _playAudio(String audioUrl, int index) async {
  //   setState(() {
  //     _playingAyahIndex = index;
  //   });

  //   try {
  //     await _audioPlayer.play(UrlSource(audioUrl)); // Play the audio
  //   } catch (e) {
  //     print("Error playing audio: $e");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDark = themeCubit.state.themeData == ThemeData.dark();
    double fontSize = 20.0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.surahDetail.ayahs.length,
        itemBuilder: (context, index) {
          final ayah = widget.surahDetail.ayahs[index];
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
              onTap: () =>
                  _onLongPress(context, widget.surahDetail, ayah, index),
            ),
          );
        },
      ),
    );
  }

  void _onLongPress(BuildContext context, SurahDetail surahDetail,
      AyahDetail ayah, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          // Add this to allow scrolling
          child: Padding(
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.indigoAccent,
                        content: Text(
                          'تمت اضافة الآية المرجعية للمفضلة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
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
                    // Add Tafseer functionality here
                  },
                ),
                ListTile(
                  trailing: const Icon(Icons.music_note),
                  title: const Text(
                    textAlign: TextAlign.end,
                    'استماع',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onTap: () {
                    // Play/Pause logic for the Ayah
                    // if (_playingAyahIndex == index) {
                    //   _audioPlayer.stop();
                    //   setState(() {
                    //     _playingAyahIndex = null;
                    //   });
                    // } else {
                    //   // _playAudio(ayah.audioUrl, index);
                    // }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
