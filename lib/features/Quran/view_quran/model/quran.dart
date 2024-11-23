import 'dart:convert';

import 'package:equatable/equatable.dart';

class Quran extends Equatable {
  final int? id;
  final int? jozz;
  final int? suraNo;
  final String? suraNameEn;
  final String? suraNameAr;
  final int? page;
  final int? lineStart;
  final int? lineEnd;
  final int? ayaNo;
  final String? ayaText;
  final String? ayaTextEmlaey;

  const Quran({
    this.id,
    this.jozz,
    this.suraNo,
    this.suraNameEn,
    this.suraNameAr,
    this.page,
    this.lineStart,
    this.lineEnd,
    this.ayaNo,
    this.ayaText,
    this.ayaTextEmlaey,
  });

  factory Quran.fromMap(Map<String, dynamic> data) => Quran(
        id: data['id'] as int?,
        jozz: data['jozz'] as int?,
        suraNo: data['sura_no'] as int?,
        suraNameEn: data['sura_name_en'] as String?,
        suraNameAr: data['sura_name_ar'] as String?,
        page: data['page'] as int?,
        lineStart: data['line_start'] as int?,
        lineEnd: data['line_end'] as int?,
        ayaNo: data['aya_no'] as int?,
        ayaText: data['aya_text'] as String?,
        ayaTextEmlaey: data['aya_text_emlaey'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'jozz': jozz,
        'sura_no': suraNo,
        'sura_name_en': suraNameEn,
        'sura_name_ar': suraNameAr,
        'page': page,
        'line_start': lineStart,
        'line_end': lineEnd,
        'aya_no': ayaNo,
        'aya_text': ayaText,
        'aya_text_emlaey': ayaTextEmlaey,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Quran].
  factory Quran.fromJson(String data) {
    return Quran.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Quran] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props {
    return [
      id,
      jozz,
      suraNo,
      suraNameEn,
      suraNameAr,
      page,
      lineStart,
      lineEnd,
      ayaNo,
      ayaText,
      ayaTextEmlaey,
    ];
  }
}
