import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:falak/app/app.dart';
import 'package:falak/app/injector.dart';
import 'package:falak/config/splash_manager.dart';
import 'package:falak/core/functions/cache_app_data.dart';

import 'core/network/socket/socket_service.dart';
import 'core/notifications/local_notifications.dart';

void main() async {
  // Preserve native splash screen
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  try {
    // Initialize core services
    await setupServiceLocator();
    await cacheAppData();

    /// NOTIFICATIONS
    // await FirebaseNotifications.initialize();
    await LocalNotificationService.initialize();

    /// SOCKET IO INIT
    await SocketService().initialize();

    // Load app settings
    SplashManager.loadAppSettings();

    // Handle splash screen logic and navigation
    await SplashManager.instance.handleSplashLogic();
  } catch (e) {
    print('Error in initialization: $e');
    // Remove splash even on error
    SplashManager.removeSplash();
  }

  runApp(DevicePreview(
    enabled: false,
    builder: (context) => MyApp(),
  ));
}

