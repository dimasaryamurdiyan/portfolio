import 'package:flutter/material.dart';

/// Utility class for color-related operations.
class ColorUtils {
  ColorUtils._();

  /// Parses a hex color string to a [Color].
  ///
  /// Supports formats: "#RRGGBB", "RRGGBB", "#AARRGGBB", "AARRGGBB"
  ///
  /// Returns [defaultColor] if the hex string is null, empty, or invalid.
  static Color parseHex(String? hexColor, {Color? defaultColor}) {
    defaultColor ??= Colors.grey.shade100;

    if (hexColor == null || hexColor.isEmpty) {
      return defaultColor;
    }

    try {
      String hex = hexColor.replaceAll('#', '');

      // Handle 6-character hex (RGB) by adding alpha
      if (hex.length == 6) {
        hex = 'FF$hex';
      }

      return Color(int.parse(hex, radix: 16));
    } catch (e) {
      return defaultColor;
    }
  }

  /// Creates a color with adjusted alpha value.
  static Color withAlpha(Color color, double alpha) {
    return color.withValues(alpha: alpha);
  }
}
