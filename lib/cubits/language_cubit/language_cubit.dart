import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  
  LanguageCubit() : super(const Locale("en"));
  void changeLanguage(String languageCode) {
    emit(Locale(languageCode));
  }
}
