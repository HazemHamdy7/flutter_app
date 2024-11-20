// import 'package:flutter_app/features/Quran/list_quran/model/list_of_surah.dart';
// import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';

// abstract class SurahState {}

// class SurahInitial extends SurahState {}

// class SurahLoading extends SurahState {}

// class SurahLoaded extends SurahState {
//   final List<SurahDetail> surahs;
//   SurahLoaded(this.surahs);
// }

// class SurahError extends SurahState {
//   final String errorMessage;
//   SurahError(this.errorMessage);
// }

import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';
import 'package:equatable/equatable.dart';

abstract class QuranState extends Equatable {
  @override
  List<Object?> get props => [];
}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final List<Surah> surahs;

  QuranLoaded(this.surahs);

  @override
  List<Object?> get props => [surahs];
}

class QuranError extends QuranState {
  final String message;

  QuranError(this.message);

  @override
  List<Object?> get props => [message];
}
