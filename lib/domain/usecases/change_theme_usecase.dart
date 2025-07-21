import 'package:flutter/material.dart';
import 'package:portfolio/domain/repositories/theme_repository.dart';

class ChangeThemeUseCase {
  final ThemeRepository _themeRepository;

  ChangeThemeUseCase(this._themeRepository);

  Future<ThemeMode> loadTheme() async {
    return await _themeRepository.fetchThemeMode();
  }

  Future<void> toggleTheme(ThemeMode currentTheme) async {
    final newTheme = currentTheme == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _themeRepository.saveThemeMode(newTheme);
  }
}