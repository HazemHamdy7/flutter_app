import 'dart:developer';
import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class SurahCubit extends Cubit<List<Surah>> {
  final List<Surah> _allSurahs = [];
  SurahCubit() : super([]);

  final Dio _dio = Dio();

  Future<void> fetchSurahs() async {
    try {
      final response = await _dio.get('https://api.alquran.cloud/v1/surah');

      if (response.data is Map<String, dynamic> &&
          response.data['data'] != null) {
        final List surahData = response.data['data'];
        final surahs = surahData.map((json) => Surah.fromJson(json)).toList();
        emit(surahs);
      } else {
        throw Exception('Unexpected JSON structure');
      }
    } catch (e) {
      log("Error fetching surahs: $e");
      emit([]); // Emit an empty list on error
    }
  }

  void filterSurahs(String query) {
    if (query.isEmpty) {
      emit(_allSurahs); 
    } else {
      final filtered = _allSurahs.where((surah) {
        final surahName = surah.name?.toLowerCase() ?? '';
        final englishName = surah.englishName?.toLowerCase() ?? '';
        final surahNumber = surah.number.toString();

        return surahName.contains(query.toLowerCase()) ||
            englishName.contains(query.toLowerCase()) ||
            surahNumber.contains(query);
      }).toList();
      emit(filtered); 
    }
  }
}
