import 'dart:developer' as developer;

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

/// Centralized analytics service using Firebase Analytics.
///
/// Uses singleton pattern for consistent event tracking across the app.
class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  AnalyticsService._internal();

  static AnalyticsService get instance => _instance;

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver get observer =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  // ============================================================
  // Private helper methods to reduce code duplication
  // ============================================================

  /// Logs an analytics event with error handling.
  Future<void> _logEvent(
    String name, {
    Map<String, Object>? parameters,
  }) async {
    try {
      final params = <String, Object>{
        'timestamp': DateTime.now().millisecondsSinceEpoch,
        ...?parameters,
      };
      await _analytics.logEvent(name: name, parameters: params);
    } catch (e, stackTrace) {
      _logError('_logEvent[$name]', e, stackTrace);
    }
  }

  /// Logs an error using dart:developer for better debugging.
  void _logError(String context, Object error, [StackTrace? stackTrace]) {
    if (kDebugMode) {
      developer.log(
        'Analytics Error - $context: $error',
        name: 'AnalyticsService',
        error: error,
        stackTrace: stackTrace,
        level: 900, // Warning level
      );
    }
  }

  // ============================================================
  // User Engagement Analytics
  // ============================================================

  /// Tracks when the portfolio page is opened.
  Future<void> trackPageOpen() async {
    await _logEvent('portfolio_page_open');
  }

  /// Tracks scroll depth milestones.
  Future<void> trackScrollDepth(double scrollPercentage, String section) async {
    await _logEvent(
      'scroll_depth',
      parameters: {
        'scroll_percentage': scrollPercentage.round(),
        'section': section,
      },
    );
  }

  /// Tracks session start (custom event, not reserved).
  Future<void> trackSessionStart() async {
    await _logEvent('portfolio_session_start');
  }

  /// Tracks session end with duration.
  Future<void> trackSessionEnd(int durationSeconds) async {
    await _logEvent(
      'portfolio_session_end',
      parameters: {'session_duration': durationSeconds},
    );
  }

  // ============================================================
  // Conversion & Contact Analytics
  // ============================================================

  /// Tracks resume download clicks.
  Future<void> trackResumeDownload() async {
    await _logEvent('resume_download');
  }

  /// Tracks email contact clicks.
  Future<void> trackEmailClick() async {
    await _logEvent(
      'email_click',
      parameters: {'contact_method': 'email'},
    );
  }

  /// Tracks social media link clicks.
  Future<void> trackSocialMediaClick(String platform) async {
    await _logEvent(
      'social_media_click',
      parameters: {'platform': platform},
    );
  }

  // ============================================================
  // Technical & Performance Analytics
  // ============================================================

  /// Tracks theme changes (light/dark).
  Future<void> trackThemeChange(String theme) async {
    await _logEvent(
      'theme_change',
      parameters: {'theme': theme},
    );
  }

  /// Tracks device and platform info.
  Future<void> trackDeviceInfo(String deviceType, String platform) async {
    await _logEvent(
      'device_info',
      parameters: {
        'device_type': deviceType,
        'platform': platform,
      },
    );
  }

  // ============================================================
  // Navigation Analytics
  // ============================================================

  /// Tracks section navigation.
  Future<void> trackSectionView(String sectionName) async {
    await _logEvent(
      'section_view',
      parameters: {'section_name': sectionName},
    );
  }

  /// Tracks project detail views.
  Future<void> trackProjectView(String projectName) async {
    await _logEvent(
      'project_view',
      parameters: {'project_name': projectName},
    );
  }

  // ============================================================
  // User Properties
  // ============================================================

  /// Sets a user property for segmentation.
  Future<void> setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e, stackTrace) {
      _logError('setUserProperty[$name]', e, stackTrace);
    }
  }
}
