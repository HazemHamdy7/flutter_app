import 'dart:convert';

QuranResponse quranResponseFromJson(String str) =>
    QuranResponse.fromJson(json.decode(str));

class QuranResponse {
  final int code;
  final String status;
  final Data data;

  QuranResponse({
    required this.code,
    required this.status,
    required this.data,
  });

  factory QuranResponse.fromJson(Map<String, dynamic> json) => QuranResponse(
        code: json["code"],
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  final List<Surah> surahs;

  Data({required this.surahs});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surahs: List<Surah>.from(json["surahs"].map((x) => Surah.fromJson(x))),
      );
}

List<Surah> surahFromJson(String str) =>
    List<Surah>.from(json.decode(str)["data"].map((x) => Surah.fromJson(x)));

class Surah {
  final int number;
  final String name;
  final String englishName;
  final String revelationType;
  final int ayahsCount;
  final int? numberInSurah;

  Surah({
    required this.number,
    required this.name,
    required this.englishName,
    required this.ayahsCount,
    required this.revelationType,
    this.numberInSurah,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        ayahsCount: json["numberOfAyahs"],
        numberInSurah: json["numberInSurah"],
        revelationType: json["revelationType"],
      );
}

class Ayah {
  final int number;
  final String text;

  Ayah({required this.number, required this.text});

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        number: json["number"],
        text: json["text"],
      );
}
