import 'package:collection/collection.dart';

import 'data.dart';

class QuranAudio {
  int? code;
  String? status;
  Data? data;

  QuranAudio({this.code, this.status, this.data});

  factory QuranAudio.fromJson(Map<String, dynamic> json) => QuranAudio(
        code: json['code'] as int?,
        status: json['status'] as String?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'status': status,
        'data': data?.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! QuranAudio) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => code.hashCode ^ status.hashCode ^ data.hashCode;
}
