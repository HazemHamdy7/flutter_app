import 'package:collection/collection.dart';

class Ayah {
  int? number;
  String? audio;
  List<String>? audioSecondary;
  String? text;
  int? numberInSurah;
  int? juz;
  int? manzil;
  int? page;
  int? ruku;
  int? hizbQuarter;
  bool? sajda;

  Ayah({
    this.number,
    this.audio,
    this.audioSecondary,
    this.text,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.sajda,
  });

  factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        number: json['number'] as int?,
        audio: json['audio'] as String?,
        audioSecondary: json['audioSecondary'] as List<String>?,
        text: json['text'] as String?,
        numberInSurah: json['numberInSurah'] as int?,
        juz: json['juz'] as int?,
        manzil: json['manzil'] as int?,
        page: json['page'] as int?,
        ruku: json['ruku'] as int?,
        hizbQuarter: json['hizbQuarter'] as int?,
        sajda: json['sajda'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'number': number,
        'audio': audio,
        'audioSecondary': audioSecondary,
        'text': text,
        'numberInSurah': numberInSurah,
        'juz': juz,
        'manzil': manzil,
        'page': page,
        'ruku': ruku,
        'hizbQuarter': hizbQuarter,
        'sajda': sajda,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Ayah) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      number.hashCode ^
      audio.hashCode ^
      audioSecondary.hashCode ^
      text.hashCode ^
      numberInSurah.hashCode ^
      juz.hashCode ^
      manzil.hashCode ^
      page.hashCode ^
      ruku.hashCode ^
      hizbQuarter.hashCode ^
      sajda.hashCode;
}
