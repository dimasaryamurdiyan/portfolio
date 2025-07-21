import 'package:flutter/material.dart';
import 'package:portfolio/domain/repositories/theme_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ThemeRepositoryImpl implements ThemeRepository {
  static const String _themeModeKey = 'theme_mode';

  @override
  Future<ThemeMode> fetchThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_themeModeKey) ?? ThemeMode.system.index;
    return ThemeMode.values[themeModeIndex];
  }

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, themeMode.index);
  }
}