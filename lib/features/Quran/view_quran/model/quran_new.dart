import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_app/features/Quran/view_quran/model/quran.dart';

class QuranNew extends Equatable {
  final List<Quran>? quran;

  const QuranNew({this.quran});

  factory QuranNew.fromMap(Map<String, dynamic> data) => QuranNew(
        quran: (data['quran'] as List<dynamic>?)
            ?.map((e) => Quran.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'quran': quran?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [QuranNew].
  factory QuranNew.fromJson(String data) {
    return QuranNew.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [QuranNew] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  List<Object?> get props => [quran];
}
