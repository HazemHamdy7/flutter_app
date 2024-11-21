import 'package:flutter/material.dart';
import 'package:flutter_app/utils/helper/custom_text.dart';

class RetunBasmala extends StatelessWidget {
  const RetunBasmala({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CustomText(
      text: 'بسم الله الرحمن الرحيم',
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontFamily: 'me_quran',
    ));
  }
}
