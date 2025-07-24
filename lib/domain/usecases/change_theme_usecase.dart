import 'package:flutter/material.dart';
import 'package:portfolio/domain/repositories/theme_repository.dart';

class ChangeThemeUseCase {
  final ThemeRepository _themeRepository;

  ChangeThemeUseCase(this._themeRepository);

  Future<ThemeMode> loadTheme() async {
    return await _themeRepository.fetchThemeMode();
  }

  Future<ThemeMode> toggleTheme(ThemeMode currentTheme) async {
    // Simple toggle between light and dark only
    final newTheme = currentTheme == ThemeMode.light 
        ? ThemeMode.dark 
        : ThemeMode.light;
    
    await _themeRepository.saveThemeMode(newTheme);
    return newTheme;
  }
}