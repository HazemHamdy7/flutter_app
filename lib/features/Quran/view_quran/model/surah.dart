// import 'ayah.dart';

// class Surah {
//   int? number;
//   String? name;
//   String? englishName;
//   String? englishNameTranslation;
//   String? revelationType;
//   List<Ayah> ayahs;

//   Surah({
//     this.number,
//     this.name,
//     this.englishName,
//     this.englishNameTranslation,
//     this.revelationType,
//     required this.ayahs,
//   });

//   factory Surah.fromJson(Map<String, dynamic> json) => Surah(
//         number: json['number'] as int?,
//         name: json['name'] as String?,
//         englishName: json['englishName'] as String?,
//         englishNameTranslation: json['englishNameTranslation'] as String?,
//         revelationType: json['revelationType'] as String?,
//         ayahs: (json['ayahs'] as List<dynamic>?)!
//             .map((e) => Ayah.fromJson(e as Map<String, dynamic>))
//             .toList(),
//       );

//   Map<String, dynamic> toJson() => {
//         'number': number,
//         'name': name,
//         'englishName': englishName,
//         'englishNameTranslation': englishNameTranslation,
//         'revelationType': revelationType,
//         'ayahs': ayahs.map((e) => e.toJson()).toList(),
//       };
// }
