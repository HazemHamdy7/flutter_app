// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:flutter_app/features/Quran/list_quran/cubit/surah_list_state.dart';
// import 'package:flutter_app/features/Quran/list_quran/model/list_of_surah.dart';
// import 'package:flutter_app/features/Quran/list_quran/model/surah_detail.dart';
// import 'package:flutter_app/utils/helper/constants.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SurahCubit extends Cubit<SurahState> {
//   SurahCubit() : super(SurahInitial());

//   Future<void> loadNameOfSurah() async {
//     emit(SurahLoading());
//     try {
//       final String response = await rootBundle.loadString(AppHelpers.quran);
//       final List<dynamic> data = json.decode(response);
//       final List<SurahDetail> surahs = data
//           .map((json) => SurahDetail.fromJson(json as Map<String, dynamic>))
//           .toList();
//       emit(SurahLoaded(surahs));
//     } catch (e) {
//       emit(SurahError('Failed to load Surah data: $e'));
//     }
//   }
// }
import 'dart:developer';

import 'package:flutter_app/features/Quran/list_quran/cubit/surah_list_state.dart';
import 'package:flutter_app/features/Quran/list_quran/model/quran_responese.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

class SurahCubit extends Cubit<List<Surah>> {
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
}

