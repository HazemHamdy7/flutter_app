import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurahDetailCubit extends Cubit<SurahDetail?> {
  SurahDetailCubit() : super(null);

  final Dio _dio = Dio();

  Future<void> fetchSurahDetail(int surahNumber) async {
    try {
      final response =
          await _dio.get('https://api.alquran.cloud/v1/surah/$surahNumber');
      final surahDetail = SurahDetail.fromJson(response.data["data"]);
      emit(surahDetail);
    } catch (e) {
      emit(const Text('data not found') as SurahDetail?);
    }
  }
}
