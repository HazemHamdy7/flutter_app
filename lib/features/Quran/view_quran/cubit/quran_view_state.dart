import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';

abstract class QuranState {}

class QuranInitial extends QuranState {}

class QuranLoading extends QuranState {}

class QuranLoaded extends QuranState {
  final List<Ayah> ayahs;
  QuranLoaded(this.ayahs);
}

class QuranError extends QuranState {
  final String errorMessage;
  QuranError(this.errorMessage);
}
