import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';

/// Centralized service for launching URLs.
/// Consolidates URL launching logic from multiple widgets.
class UrlLauncherService {
  UrlLauncherService._();

  /// Launches a URL in the default browser or appropriate app.
  ///
  /// [url] The URL to launch.
  /// [mode] The launch mode (defaults to external application).
  ///
  /// Returns true if the URL was launched successfully, false otherwise.
  static Future<bool> launch(
    String url, {
    LaunchMode mode = LaunchMode.externalApplication,
  }) async {
    try {
      final Uri uri = Uri.parse(url);

      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: mode);
      } else {
        _logError('Cannot launch URL: $url');
        return false;
      }
    } catch (e, stackTrace) {
      _logError('Error launching URL: $url', e, stackTrace);
      return false;
    }
  }

  /// Launches an email client with the specified email address.
  static Future<bool> launchEmail(String email) async {
    return launch('mailto:$email');
  }

  /// Launches a phone dialer with the specified phone number.
  static Future<bool> launchPhone(String phoneNumber) async {
    return launch('tel:$phoneNumber');
  }

  static void _logError(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      developer.log(
        message,
        name: 'UrlLauncherService',
        error: error,
        stackTrace: stackTrace,
        level: 900, // Warning level
      );
    }
  }
}
