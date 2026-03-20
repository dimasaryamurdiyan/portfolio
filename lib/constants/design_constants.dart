/// Design constants used throughout the app.
/// Centralizes magic numbers for consistent styling.
class DesignConstants {
  DesignConstants._();

  // Breakpoints
  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 800;
  static const double desktopBreakpoint = 1200;

  // Padding
  static const double paddingLargeVertical = 120;
  static const double paddingSmallVertical = 80;
  static const double paddingLargeHorizontal = 120;
  static const double paddingSmallHorizontal = 40;

  // Animation durations (in milliseconds)
  static const int animationFast = 200;
  static const int animationNormal = 300;
  static const int animationSlow = 500;

  // Font sizes
  static const double headingLarge = 64;
  static const double headingMedium = 48;
  static const double headingSmall = 40;
  static const double titleLarge = 32;
  static const double titleMedium = 28;
  static const double titleSmall = 24;
  static const double bodyLarge = 18;
  static const double bodyMedium = 16;
  static const double bodySmall = 14;
  static const double captionSize = 12;

  // Border radius
  static const double radiusSmall = 6;
  static const double radiusMedium = 12;
  static const double radiusLarge = 16;
  static const double radiusXLarge = 24;

  // Card dimensions
  static const double cardAspectRatioLarge = 0.72;
  static const double cardAspectRatioMedium = 0.75;
  static const double cardAspectRatioSmall = 0.85;

  // Image carousel
  static const double carouselHeightLarge = 350;
  static const double carouselHeightSmall = 260;

  // Logo badge sizes
  static const double logoBadgeLarge = 64;
  static const double logoBadgeMedium = 56;
  static const double logoBadgeSmall = 44;

  // Max widths
  static const double maxContentWidth = 1200;
  static const double maxDialogWidth = 800;
}

/// Breakpoint helper extension for responsive design.
extension BreakpointExtension on double {
  bool get isLargeScreen => this > DesignConstants.tabletBreakpoint;
  bool get isMediumScreen => this > DesignConstants.mobileBreakpoint;
  bool get isSmallScreen => this <= DesignConstants.mobileBreakpoint;
}
