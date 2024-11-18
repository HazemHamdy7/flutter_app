import 'package:equatable/equatable.dart';

import 'edition.dart';
import 'surah.dart';

class Data extends Equatable {
  final List<Surah>? surahs;
  final Edition? edition;

  const Data({this.surahs, this.edition});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        surahs: (json['surahs'] as List<dynamic>?)
            ?.map((e) => Surah.fromJson(e as Map<String, dynamic>))
            .toList(),
        edition: json['edition'] == null
            ? null
            : Edition.fromJson(json['edition'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'surahs': surahs?.map((e) => e.toJson()).toList(),
        'edition': edition?.toJson(),
      };

  @override
  List<Object?> get props => [surahs, edition];
}
