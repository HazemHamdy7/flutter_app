class _ArabicNumber {
  static String convert(Object value) {
    assert(
      value is int || value is String,
    );

    if (value is int) {
      return _toArabicNumber(value.toString());
    } else {
      return _toArabicNumber(value as String);
    }
  }

  static String _toArabicNumber(String value) {
    return value
        .replaceAll('0', '٠')
        .replaceAll('1', '١')
        .replaceAll('2', '٢')
        .replaceAll('3', '٣')
        .replaceAll('4', '٤')
        .replaceAll('5', '٥')
        .replaceAll('6', '٦')
        .replaceAll('7', '٧')
        .replaceAll('8', '٨')
        .replaceAll('9', '٩');
  }
}

extension IntExtensions on int {
  String get toArabicNumbers {
    return _ArabicNumber.convert(this);
  }
}

extension StringExtensions on String {
  String get toArabicNumbers {
    return _ArabicNumber.convert(this);
  }
}
