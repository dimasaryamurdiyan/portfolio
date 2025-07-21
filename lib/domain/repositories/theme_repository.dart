import 'package:flutter/material.dart';

abstract class ThemeRepository {
  Future<ThemeMode> fetchThemeMode();
  Future<void> saveThemeMode(ThemeMode themeMode);
}