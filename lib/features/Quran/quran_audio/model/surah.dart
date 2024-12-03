import 'package:collection/collection.dart';

import 'ayah.dart';

class Surah {
  int? number;
  String? name;
  String? englishName;
  String? englishNameTranslation;
  String? revelationType;
  List<Ayah>? ayahs;

  Surah({
    this.number,
    this.name,
    this.englishName,
    this.englishNameTranslation,
    this.revelationType,
    this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        number: json['number'] as int?,
        name: json['name'] as String?,
        englishName: json['englishName'] as String?,
        englishNameTranslation: json['englishNameTranslation'] as String?,
        revelationType: json['revelationType'] as String?,
        ayahs: (json['ayahs'] as List<dynamic>?)
            ?.map((e) => Ayah.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'name': name,
        'englishName': englishName,
        'englishNameTranslation': englishNameTranslation,
        'revelationType': revelationType,
        'ayahs': ayahs?.map((e) => e.toJson()).toList(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Surah) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      number.hashCode ^
      name.hashCode ^
      englishName.hashCode ^
      englishNameTranslation.hashCode ^
      revelationType.hashCode ^
      ayahs.hashCode;
}
