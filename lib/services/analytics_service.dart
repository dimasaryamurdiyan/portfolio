import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();
  factory AnalyticsService() => _instance;
  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;
  FirebaseAnalyticsObserver get observer => FirebaseAnalyticsObserver(analytics: _analytics);

  // User Engagement Analytics
  Future<void> trackPageOpen() async {
    try {
      await _analytics.logEvent(
        name: 'portfolio_page_open',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackPageOpen: $e');
      }
    }
  }

  Future<void> trackScrollDepth(double scrollPercentage, String section) async {
    try {
      await _analytics.logEvent(
        name: 'scroll_depth',
        parameters: {
          'scroll_percentage': scrollPercentage.round(),
          'section': section,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackScrollDepth: $e');
      }
    }
  }

  Future<void> trackSessionStart() async {
    try {
      await _analytics.logEvent(
        name: 'session_start',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackSessionStart: $e');
      }
    }
  }

  Future<void> trackSessionEnd(int durationSeconds) async {
    try {
      await _analytics.logEvent(
        name: 'session_end',
        parameters: {
          'session_duration': durationSeconds,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackSessionEnd: $e');
      }
    }
  }

  // Conversion & Contact Analytics
  Future<void> trackResumeDownload() async {
    try {
      await _analytics.logEvent(
        name: 'resume_download',
        parameters: {
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackResumeDownload: $e');
      }
    }
  }

  Future<void> trackEmailClick() async {
    try {
      await _analytics.logEvent(
        name: 'email_click',
        parameters: {
          'contact_method': 'email',
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackEmailClick: $e');
      }
    }
  }

  Future<void> trackSocialMediaClick(String platform) async {
    try {
      await _analytics.logEvent(
        name: 'social_media_click',
        parameters: {
          'platform': platform,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackSocialMediaClick: $e');
      }
    }
  }

  // Technical & Performance Analytics
  Future<void> trackThemeChange(String theme) async {
    try {
      await _analytics.logEvent(
        name: 'theme_change',
        parameters: {
          'theme': theme,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackThemeChange: $e');
      }
    }
  }

  Future<void> trackDeviceInfo(String deviceType, String platform) async {
    try {
      await _analytics.logEvent(
        name: 'device_info',
        parameters: {
          'device_type': deviceType,
          'platform': platform,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackDeviceInfo: $e');
      }
    }
  }

  // Section viewing analytics
  Future<void> trackSectionView(String sectionName) async {
    try {
      await _analytics.logEvent(
        name: 'section_view',
        parameters: {
          'section_name': sectionName,
          'timestamp': DateTime.now().millisecondsSinceEpoch,
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - trackSectionView: $e');
      }
    }
  }

  // Set user properties
  Future<void> setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      if (kDebugMode) {
        print('Analytics Error - setUserProperty: $e');
      }
    }
  }
}