import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_app/cubits/surah_list_cubit/surah_list_state.dart';
import 'package:flutter_app/model/list_of_surah/list_of_surah.dart';
import 'package:flutter_app/utils/helper/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit() : super(SurahInitial());

  Future<void> loadSurahs() async {
    emit(SurahLoading());
    try {
      final String response = await rootBundle.loadString(AppHelpers.quranList);
      final List<dynamic> data = json.decode(response);
      final List<ListOfSurah> surahs = data
          .map((json) => ListOfSurah.fromJson(json as Map<String, dynamic>))
          .toList();
      emit(SurahLoaded(surahs));
    } catch (e) {
      emit(SurahError('Failed to load Surah data: $e'));
    }
  }
}
