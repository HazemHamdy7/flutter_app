import 'package:collection/collection.dart';

import 'edition.dart';
import 'surah.dart';

class Data {
  List<Surah>? surahs;
  Edition? edition;

  Data({this.surahs, this.edition});

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
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Data) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => surahs.hashCode ^ edition.hashCode;
}
