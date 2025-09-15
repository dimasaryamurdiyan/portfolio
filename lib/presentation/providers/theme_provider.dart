// Provider for the concrete ThemeRepository implementation
import 'package:flutter/material.dart';
import 'package:portfolio/data/repositories/theme_repository_impl.dart';
import 'package:portfolio/domain/repositories/theme_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/domain/usecases/change_theme_usecase.dart';
import 'package:portfolio/services/analytics_service.dart';

final themeRepositoryProvider = Provider<ThemeRepository>((ref) => ThemeRepositoryImpl());

// Provider for the ChangeThemeUseCase
final changeThemeUseCaseProvider = Provider<ChangeThemeUseCase>((ref) {
  return ChangeThemeUseCase(ref.watch(themeRepositoryProvider));
});

// Notifier for the ThemeMode state
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  final ChangeThemeUseCase _changeThemeUseCase;
  final AnalyticsService _analytics = AnalyticsService.instance;

  ThemeModeNotifier(this._changeThemeUseCase) : super(ThemeMode.system) {
    _loadInitialTheme();
  }

  Future<void> _loadInitialTheme() async {
    state = await _changeThemeUseCase.loadTheme();
  }

  Future<void> toggleTheme() async {
    final newTheme = await _changeThemeUseCase.toggleTheme(state);
    
    // Track theme change analytics
    String themeString = _themeToString(newTheme);
    await _analytics.trackThemeChange(themeString);
    await _analytics.setUserProperty('preferred_theme', themeString);
    
    state = newTheme;
  }
  
  String _themeToString(ThemeMode theme) {
    switch (theme) {
      case ThemeMode.light:
        return 'light';
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.system:
        return 'system';
    }
  }
}

// StateNotifierProvider for ThemeModeNotifier
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier(ref.watch(changeThemeUseCaseProvider));
});