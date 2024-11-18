class ListOfSurah {
  int number;
  String name;
  String englishName;
  String? englishNameTranslation;
  int? numberOfAyahs;
  String? revelationType;

  ListOfSurah({
    required this.number,
    required this.name,
    required this.englishName,
    this.englishNameTranslation,
    this.numberOfAyahs,
    this.revelationType,
  });

  factory ListOfSurah.fromJson(Map<String, dynamic> json) => ListOfSurah(
        number: json['number'] as int,
        name: json['name'] as String,
        englishName: json['englishName'] as String,
        englishNameTranslation: json['englishNameTranslation'] as String?,
        numberOfAyahs: json['numberOfAyahs'] as int?,
        revelationType: json['revelationType'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'name': name,
        'englishName': englishName,
        'englishNameTranslation': englishNameTranslation,
        'numberOfAyahs': numberOfAyahs,
        'revelationType': revelationType,
      };
}
