import 'package:flutter/material.dart';
import 'package:portfolio/domain/repositories/theme_repository.dart';

class ChangeThemeUseCase {
  final ThemeRepository _themeRepository;

  ChangeThemeUseCase(this._themeRepository);

  Future<ThemeMode> loadTheme() async {
    return await _themeRepository.fetchThemeMode();
  }

  Future<void> toggleTheme(ThemeMode currentTheme) async {
    ThemeMode newTheme;
    
    // Cycle through: light -> dark -> system -> light
    switch (currentTheme) {
      case ThemeMode.light:
        newTheme = ThemeMode.dark;
        break;
      case ThemeMode.dark:
        newTheme = ThemeMode.system;
        break;
      case ThemeMode.system:
        newTheme = ThemeMode.light;
        break;
    }
    
    await _themeRepository.saveThemeMode(newTheme);
  }
}