import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:falak/app/app.dart';
import 'package:falak/app/injector.dart';
import 'package:falak/core/functions/local_auth.dart';
import 'package:falak/core/storage/flutter_secure_storage.dart';
import 'package:falak/core/storage/i_app_local_storage.dart';
import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/utils/constant.dart';
import 'package:falak/core/utils/app_logger.dart';

class SplashManager {
  SplashManager._();

  static final SplashManager _instance = SplashManager._();
  static SplashManager get instance => _instance;
  Future<void> handleSplashLogic() async {
    try {
      final isAppLocked = _isAppLocked();
      AppLogger.splash('App lock status: ${isAppLocked ? "Locked 🔒" : "Unlocked 🔓"}');

      if (isAppLocked) {
        await _handleLockedApp();
      } else {
        await _handleUnlockedApp();
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error in splash logic', error: e, stackTrace: stackTrace);
      FlutterNativeSplash.remove();
    }
  }

  Future<void> _handleLockedApp() async {
    AppLogger.splash('Removing splash for authentication...');
    FlutterNativeSplash.remove();

    final authenticated = await _authenticateUser();

    if (authenticated) {
      AppLogger.auth('Authentication successful ✅');
      await _determineInitialRoute();
    } else {
      AppLogger.auth('Authentication failed - staying on lock screen ❌');
    }
  }

  Future<void> _handleUnlockedApp() async {
    AppLogger.splash('Showing splash screen for 3 seconds...');
    await Future.delayed(const Duration(seconds: 3));

    await _determineInitialRoute();

    AppLogger.splash('Removing splash screen...');
    FlutterNativeSplash.remove();
  }

  Future<bool> _authenticateUser() async {
    try {
      AppLogger.auth('Requesting biometric authentication...');
      final result = await authenticateUser('الرجاء المصادقة للوصول إلى التطبيق');
      return result;
    } catch (e, stackTrace) {
      AppLogger.error('Authentication error', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  Future<void> _determineInitialRoute() async {
    try {
      AppLogger.splash('Checking user login status...');
      final cookie = await SecureStorageServices().getCookie();

      if (cookie != null) {
        KisGuest = false;
        AppLogger.success('User is logged in 👤');
      } else {
        KisGuest = true;
        AppLogger.info('User is in guest mode 👥');
      }
    } catch (e, stackTrace) {
      AppLogger.error('Error determining route', error: e, stackTrace: stackTrace);
      KisGuest = true;
      AppLogger.warning('Defaulting to guest mode due to error');
    }
  }

  bool _isAppLocked() {
    try {
      return serviceLocator<IAppLocalStorage>()
              .getValue(AppStrings.isAppLocked) ??
          false;
    } catch (e, stackTrace) {
      AppLogger.error('Error checking app lock status', error: e, stackTrace: stackTrace);
      return false;
    }
  }

  static void loadAppSettings() {
    try {
      AppConstant.KisHijri = serviceLocator<IAppLocalStorage>()
              .getValue(AppStrings.KisHijri) ??
          false;
      AppLogger.info('App settings loaded - KisHijri: ${AppConstant.KisHijri}');
    } catch (e, stackTrace) {
      AppLogger.error('Error loading app settings', error: e, stackTrace: stackTrace);
      AppConstant.KisHijri = false;
    }
  }

  static void removeSplash() {
    try {
      FlutterNativeSplash.remove();
      AppLogger.splash('Native splash removed');
    } catch (e, stackTrace) {
      AppLogger.error('Error removing splash', error: e, stackTrace: stackTrace);
    }
  }
}

