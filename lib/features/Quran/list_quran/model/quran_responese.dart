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
  final String text;
  final int number;
  final int numberInSurah;
  final int juz;
  final int manzil;
  final int page;
  final int ruku;
  final int hizbQuarter;
  final bool sajda;

  Ayah(
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda, {
    required this.number,
    required this.text,
  });
  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        json["numberInSurah"],
        json["juz"],
        json["manzil"],
        json["page"],
        json["ruku"],
        json["hizbQuarter"],
        json["sajda"],
        number: json["number"],
        text: json["text"],
      );
}
