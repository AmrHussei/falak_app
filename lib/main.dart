import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:falak/app/app.dart';
import 'package:falak/app/injector.dart';
import 'package:falak/config/splash_manager.dart';
import 'package:falak/core/functions/cache_app_data.dart';
import 'package:falak/core/utils/app_logger.dart';

import 'core/network/socket/socket_service.dart';
import 'core/notifications/local_notifications.dart';

void main() async {
  // Preserve native splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    AppLogger.section('APP INITIALIZATION');

    // Initialize core services
    AppLogger.info('Initializing service locator...');
    await setupServiceLocator();
    AppLogger.success('Service locator initialized');

    AppLogger.info('Caching app data...');
    await cacheAppData();
    AppLogger.success('App data cached');

    /// NOTIFICATIONS
    // await FirebaseNotifications.initialize();
    AppLogger.info('Initializing local notifications...');
    await LocalNotificationService.initialize();
    AppLogger.success('Local notifications initialized');

    /// SOCKET IO INIT
    AppLogger.info('Initializing socket service...');
    await SocketService().initialize();
    AppLogger.success('Socket service initialized');

    // Load app settings
    AppLogger.info('Loading app settings...');
    SplashManager.loadAppSettings();
    AppLogger.success('App settings loaded');

    // Handle splash screen logic and navigation
    AppLogger.splash('Handling splash logic...');
    await SplashManager.instance.handleSplashLogic();

    AppLogger.divider();
    AppLogger.success('App initialization completed successfully');
    AppLogger.divider();
  } catch (e, stackTrace) {
    AppLogger.error('Error in initialization', error: e, stackTrace: stackTrace);
    // Remove splash even on error
    SplashManager.removeSplash();
  }

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ));
}

