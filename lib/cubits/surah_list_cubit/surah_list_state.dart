import 'package:flutter_app/model/list_of_surah/list_of_surah.dart';

abstract class SurahState {}

class SurahInitial extends SurahState {}

class SurahLoading extends SurahState {}

class SurahLoaded extends SurahState {
  final List<ListOfSurah> surahs;
  SurahLoaded(this.surahs);
}

class SurahError extends SurahState {
  final String errorMessage;
  SurahError(this.errorMessage);
}