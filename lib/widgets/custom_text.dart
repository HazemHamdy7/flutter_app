import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    TextAlign textAlign = TextAlign.center,
    required this.text,
    this.fontFamily,
    required int fontSize,
    required FontWeight fontWeight,
    required Color color,
  });

  final String text;
  final String? fontFamily;
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: textAlign,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: fontFamily,
        ));
  }
}
