import 'package:flutter/material.dart';
import 'package:flutter_app/utils/helper/to_arabic.dart';
 
class ArabicSurahNumber extends StatelessWidget {
  const ArabicSurahNumber({super.key, required this.i});

  final int i;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      "\uFD3E${(i + 1).toString().toArabicNumbers}\uFD3F",
      style: const TextStyle(
          fontFamily: 'me_quran',
          color: Color.fromARGB(255, 0, 0, 0),
          fontSize: 15,
          shadows: [
            Shadow(
              blurRadius: 1.0,
              color: Colors.amberAccent,
              offset: Offset(5, 5),
            ),
          ]),
    ));
  }
}
