import 'package:collection/collection.dart';

class Edition {
  String? identifier;
  String? language;
  String? name;
  String? englishName;
  String? format;
  String? type;

  Edition({
    this.identifier,
    this.language,
    this.name,
    this.englishName,
    this.format,
    this.type,
  });

  factory Edition.fromJson(Map<String, dynamic> json) => Edition(
        identifier: json['identifier'] as String?,
        language: json['language'] as String?,
        name: json['name'] as String?,
        englishName: json['englishName'] as String?,
        format: json['format'] as String?,
        type: json['type'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'identifier': identifier,
        'language': language,
        'name': name,
        'englishName': englishName,
        'format': format,
        'type': type,
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Edition) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode =>
      identifier.hashCode ^
      language.hashCode ^
      name.hashCode ^
      englishName.hashCode ^
      format.hashCode ^
      type.hashCode;
}
