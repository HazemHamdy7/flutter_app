 
import 'package:flutter_app/features/Quran/quran_audio/model/quran_audio.dart';

abstract class QuranAudioState {}

class QuranAudioInitial extends QuranAudioState {}

class QuranAudioLoading extends QuranAudioState {}

class QuranAudioLoaded extends QuranAudioState {
  final QuranAudio quran;

  QuranAudioLoaded(this.quran);
}

class QuranAudioError extends QuranAudioState {
  final String message;

  QuranAudioError(this.message);
}
