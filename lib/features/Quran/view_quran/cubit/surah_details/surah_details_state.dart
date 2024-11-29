import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';

abstract class SurahDetailsState {}

class QuranInitial extends SurahDetailsState {}

class QuranLoading extends SurahDetailsState {}

class QuranLoaded extends SurahDetailsState {
  final List<Ayah> ayahs;
  QuranLoaded(this.ayahs);
}

class QuranError extends SurahDetailsState {
  final String errorMessage;
  QuranError(this.errorMessage);
}
