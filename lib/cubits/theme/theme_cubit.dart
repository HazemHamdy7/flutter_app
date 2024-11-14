import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static final _lightTheme = ThemeData.light();
  static final _darkTheme = ThemeData.dark();
  ThemeCubit() : super(ThemeState(_lightTheme));

  void toggleTheme(bool isDark) {
    final themeData = isDark ? _darkTheme : _lightTheme;
    emit(ThemeState(themeData));
    _saveTheme(isDark);
  }

  Future<void> _saveTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', isDark);
  }

  static Future<bool> loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDark') ?? false;
  }

  Future<void> setInintialTheme() async {
    final isDark = await loadTheme();
    final themeData = isDark ? _darkTheme : _lightTheme;
    emit(ThemeState(themeData));
  }
}
