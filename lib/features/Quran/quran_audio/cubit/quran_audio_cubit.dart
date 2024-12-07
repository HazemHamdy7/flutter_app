import 'package:dio/dio.dart';
import 'package:flutter_app/features/Quran/quran_audio/cubit/quran_sound_state.dart';
import 'package:flutter_app/features/Quran/quran_audio/model/quran_audio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuranAudioCubit extends Cubit<QuranAudioState> {
  final Dio _dio = Dio(); // Dio instance

  QuranAudioCubit() : super(QuranAudioInitial());

  Future<void> fetchQuranData() async {
    emit(QuranAudioLoading());

    try {
      final response =
          await _dio.get('https://api.alquran.cloud/v1/quran/ar.alafasy');

      if (response.statusCode == 200) {
        QuranAudio quranResponse = QuranAudio.fromJson(response.data);
        emit(QuranAudioLoaded(quranResponse));
      } else {
        emit(QuranAudioError('Failed to load Quran data'));
      }
    } catch (e) {
      emit(QuranAudioError('An error occurred: $e'));
    }
  }
}
