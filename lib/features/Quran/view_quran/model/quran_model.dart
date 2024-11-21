// class Quran {
//   List<Surah> surahs;
//   Edition edition;

//   Quran({required this.surahs, required this.edition});

//   factory Quran.fromJson(Map<String, dynamic> json) {
//     return Quran(
//       surahs: (json['surahs'] as List)
//           .map((surah) => Surah.fromJson(surah))
//           .toList(),
//       edition: Edition.fromJson(json['edition']),
//     );
//   }
// }

// class Surah {
//   int number;
//   String name;
//   String englishName;
//   String englishNameTranslation;
//   List<Ayah> ayahs;

//   Surah({
//     required this.number,
//     required this.name,
//     required this.englishName,
//     required this.englishNameTranslation,
//     required this.ayahs,
//   });

//   factory Surah.fromJson(Map<String, dynamic> json) {
//     return Surah(
//       number: json['number'],
//       name: json['name'],
//       englishName: json['englishName'],
//       englishNameTranslation: json['englishNameTranslation'],
//       ayahs:
//           (json['ayahs'] as List).map((ayah) => Ayah.fromJson(ayah)).toList(),
//     );
//   }
// }

// class Ayah {
//   int number;
//   String text;
//   int numberInSurah;
//   int juz;
//   int manzil;
//   int page;
//   int ruku;
//   int hizbQuarter;
//   bool sajda;

//   Ayah({
//     required this.number,
//     required this.text,
//     required this.numberInSurah,
//     required this.juz,
//     required this.manzil,
//     required this.page,
//     required this.ruku,
//     required this.hizbQuarter,
//     required this.sajda,
//   });

//   factory Ayah.fromJson(Map<String, dynamic> json) {
//     return Ayah(
//       number: json['number'],
//       text: json['text'],
//       numberInSurah: json['numberInSurah'],
//       juz: json['juz'],
//       manzil: json['manzil'],
//       page: json['page'],
//       ruku: json['ruku'],
//       hizbQuarter: json['hizbQuarter'],
//       sajda: json['sajda'],
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'number': number,
//         'text': text,
//         'numberInSurah': numberInSurah,
//         'juz': juz,
//         'manzil': manzil,
//         'page': page,
//         'ruku': ruku,
//         'hizbQuarter': hizbQuarter,
//         'sajda': sajda,
//       };
// }

// class Edition {
//   String identifier;
//   String language;
//   String name;
//   String englishName;
//   String format;
//   String type;

//   Edition({
//     required this.identifier,
//     required this.language,
//     required this.name,
//     required this.englishName,
//     required this.format,
//     required this.type,
//   });

//   factory Edition.fromJson(Map<String, dynamic> json) {
//     return Edition(
//       identifier: json['identifier'],
//       language: json['language'],
//       name: json['name'],
//       englishName: json['englishName'],
//       format: json['format'],
//       type: json['type'],
//     );
//   }
// }
