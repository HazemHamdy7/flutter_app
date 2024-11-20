// import 'dart:convert';

// import 'package:flutter/services.dart';
// import 'package:flutter_app/features/Quran/view_quran/cubit/quran_view_state.dart';
// import 'package:flutter_app/features/Quran/view_quran/model/quran_model.dart';
// import 'package:flutter_app/utils/helper/constants.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class QuranCubit extends Cubit<QuranState> {
//   QuranCubit() : super(QuranInitial());

//   Future<void> loadAyahs() async {
//     emit(QuranLoading());
//     try {
//       final String response =
//           await rootBundle.loadString(AppHelpers.quranJsonPath);
//       final List<dynamic> data = json.decode(response);
//       final List<Ayah> quarnOfAyah = data
//           .map((json) => Ayah.fromJson(json as Map<String, dynamic>))
//           .toList();
//       emit(QuranLoaded(quarnOfAyah));
//     } catch (e) {
//       emit(QuranError('Failed to load Quarn data: $e'));
//     }
//   }
// }

import 'package:dio/dio.dart';
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
      print("Error: $e");
      emit(null);
    }
  }
}
