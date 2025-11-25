import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

/// Centralized logging utility for the application
///
/// Provides consistent logging across the app with different log levels.
/// In production, logs can be disabled or filtered based on level.
///
/// Usage:
/// ```dart
/// AppLogger.info('User logged in');
/// AppLogger.error('Failed to load data', error: e, stackTrace: stackTrace);
/// AppLogger.debug('Current state: $state');
/// ```
class AppLogger {
  AppLogger._();

  /// Whether logging is enabled
  /// Set to false in production to disable all logs
  static bool _isEnabled = kDebugMode;

  /// Enable or disable logging
  static void setEnabled(bool enabled) {
    _isEnabled = enabled;
  }

  /// Log levels for filtering
  static const String _tagInfo = '📘 INFO';
  static const String _tagDebug = '🔍 DEBUG';
  static const String _tagWarning = '⚠️  WARNING';
  static const String _tagError = '❌ ERROR';
  static const String _tagSuccess = '✅ SUCCESS';
  static const String _tagNetwork = '🌐 NETWORK';
  static const String _tagAuth = '🔐 AUTH';
  static const String _tagSplash = '🚀 SPLASH';
  static const String _tagSocket = '🔌 SOCKET';
  static const String _tagNotification = '🔔 NOTIFICATION';

  /// General information log
  ///
  /// Example:
  /// ```dart
  /// AppLogger.info('App initialized successfully');
  /// ```
  static void info(String message, {String? tag}) {
    _log(_tagInfo, message, tag: tag);
  }

  /// Debug log - for development debugging
  ///
  /// Example:
  /// ```dart
  /// AppLogger.debug('Current user state: $userState');
  /// ```
  static void debug(String message, {String? tag}) {
    if (!kDebugMode) return; // Only log in debug mode
    _log(_tagDebug, message, tag: tag);
  }

  /// Warning log - for potential issues
  ///
  /// Example:
  /// ```dart
  /// AppLogger.warning('API response took longer than expected');
  /// ```
  static void warning(String message, {String? tag}) {
    _log(_tagWarning, message, tag: tag);
  }

  /// Error log - for errors and exceptions
  ///
  /// Example:
  /// ```dart
  /// AppLogger.error('Failed to fetch data', error: e, stackTrace: stackTrace);
  /// ```
  static void error(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String? tag,
  }) {
    _log(_tagError, message, tag: tag);
    if (error != null) {
      _log(_tagError, 'Error details: $error', tag: tag);
    }
    if (stackTrace != null && kDebugMode) {
      _log(_tagError, 'Stack trace:\n$stackTrace', tag: tag);
    }
  }

  /// Success log - for successful operations
  ///
  /// Example:
  /// ```dart
  /// AppLogger.success('User logged in successfully');
  /// ```
  static void success(String message, {String? tag}) {
    _log(_tagSuccess, message, tag: tag);
  }

  /// Network-specific log
  ///
  /// Example:
  /// ```dart
  /// AppLogger.network('GET /api/users - 200 OK');
  /// ```
  static void network(String message, {String? tag}) {
    _log(_tagNetwork, message, tag: tag);
  }

  /// Authentication-specific log
  ///
  /// Example:
  /// ```dart
  /// AppLogger.auth('Biometric authentication successful');
  /// ```
  static void auth(String message, {String? tag}) {
    _log(_tagAuth, message, tag: tag);
  }

  /// Splash screen-specific log
  ///
  /// Example:
  /// ```dart
  /// AppLogger.splash('Splash logic completed');
  /// ```
  static void splash(String message, {String? tag}) {
    _log(_tagSplash, message, tag: tag);
  }

  /// Socket-specific log
  ///
  /// Example:
  /// ```dart
  /// AppLogger.socket('Socket connected to server');
  /// ```
  static void socket(String message, {String? tag}) {
    _log(_tagSocket, message, tag: tag);
  }

  /// Notification-specific log
  ///
  /// Example:
  /// ```dart
  /// AppLogger.notification('Push notification received');
  /// ```
  static void notification(String message, {String? tag}) {
    _log(_tagNotification, message, tag: tag);
  }

  /// Internal logging method
  static void _log(String level, String message, {String? tag}) {
    if (!_isEnabled) return;

    final timestamp = DateTime.now().toIso8601String().split('T')[1].substring(0, 12);
    final tagStr = tag != null ? '[$tag] ' : '';
    final logMessage = '$timestamp $level $tagStr$message';

    // Use developer.log for better integration with DevTools
    developer.log(
      message,
      time: DateTime.now(),
      name: level,
    );

    // Also print to console for easy visibility
    if (kDebugMode) {
      debugPrint(logMessage);
    } else {
      print(logMessage);
    }
  }

  /// Log a divider line (useful for separating log sections)
  ///
  /// Example:
  /// ```dart
  /// AppLogger.divider();
  /// ```
  static void divider({String char = '─', int length = 80}) {
    if (!_isEnabled) return;
    final line = char * length;
    debugPrint(line);
  }

  /// Log a section header
  ///
  /// Example:
  /// ```dart
  /// AppLogger.section('INITIALIZATION');
  /// ```
  static void section(String title) {
    if (!_isEnabled) return;
    divider();
    info(title.toUpperCase());
    divider();
  }

  /// Log an object (pretty prints complex objects)
  ///
  /// Example:
  /// ```dart
  /// AppLogger.object('User Data', userData);
  /// ```
  static void object(String label, Object? obj) {
    if (!_isEnabled) return;
    debug('$label: ${obj.toString()}');
  }

  /// Log a JSON object (for API responses, etc.)
  ///
  /// Example:
  /// ```dart
  /// AppLogger.json('API Response', jsonData);
  /// ```
  static void json(String label, dynamic json) {
    if (!_isEnabled) return;
    try {
      debug('$label: $json');
    } catch (e) {
      error('Failed to log JSON: $label', error: e);
    }
  }
}

