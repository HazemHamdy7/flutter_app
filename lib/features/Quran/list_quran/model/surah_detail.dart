class SurahDetail {
  final int number;
  final String name;
  final String englishName;
  final List<AyahDetail> ayahs;

  SurahDetail({
    required this.number,
    required this.name,
    required this.englishName,
    required this.ayahs,
  });

  factory SurahDetail.fromJson(Map<String, dynamic> json) => SurahDetail(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        ayahs: List<AyahDetail>.from(
            json["ayahs"].map((x) => AyahDetail.fromJson(x))),
      );
}

class AyahDetail {
  late final int numberInSurah;
  late final String text;

  AyahDetail({
    required this.numberInSurah,
    required this.text,
  });

  factory AyahDetail.fromJson(Map<String, dynamic> json) => AyahDetail(
        numberInSurah: json["numberInSurah"],
        text: json["text"],
      );
}
