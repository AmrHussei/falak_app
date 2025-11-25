import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:falak/app/app.dart';
import 'package:falak/app/injector.dart';
import 'package:falak/core/functions/local_auth.dart';
import 'package:falak/core/storage/flutter_secure_storage.dart';
import 'package:falak/core/storage/i_app_local_storage.dart';
import 'package:falak/core/utils/app_strings.dart';
import 'package:falak/core/utils/constant.dart';

class SplashManager {
  SplashManager._();

  static final SplashManager _instance = SplashManager._();
  static SplashManager get instance => _instance;
  Future<void> handleSplashLogic() async {
    try {
      final isAppLocked = _isAppLocked();

      if (isAppLocked) {
        await _handleLockedApp();
      } else {
        await _handleUnlockedApp();
      }
    } catch (e) {
      print('Error in splash logic: $e');
      FlutterNativeSplash.remove();
    }
  }

  Future<void> _handleLockedApp() async {
    FlutterNativeSplash.remove();

    final authenticated = await _authenticateUser();

    if (authenticated) {
      await _determineInitialRoute();
    } else {
      print('Authentication failed - staying on lock screen');
    }
  }

  Future<void> _handleUnlockedApp() async {
    await Future.delayed(const Duration(seconds: 3));

    await _determineInitialRoute();

    FlutterNativeSplash.remove();
  }

  Future<bool> _authenticateUser() async {
    try {
      return await authenticateUser('الرجاء المصادقة للوصول إلى التطبيق');
    } catch (e) {
      print('Authentication error: $e');
      return false;
    }
  }

  Future<void> _determineInitialRoute() async {
    try {
      final cookie = await SecureStorageServices().getCookie();

      if (cookie != null) {
        KisGuest = false;
        print('User is logged in');
      } else {
        KisGuest = true;
        print('User is in guest mode');
      }
    } catch (e) {
      print('Error determining route: $e');
      KisGuest = true;
    }
  }

  bool _isAppLocked() {
    try {
      return serviceLocator<IAppLocalStorage>()
              .getValue(AppStrings.isAppLocked) ??
          false;
    } catch (e) {
      print('Error checking app lock status: $e');
      return false;
    }
  }

  static void loadAppSettings() {
    try {
      AppConstant.KisHijri = serviceLocator<IAppLocalStorage>()
              .getValue(AppStrings.KisHijri) ??
          false;
      print('App settings loaded - KisHijri: ${AppConstant.KisHijri}');
    } catch (e) {
      print('Error loading app settings: $e');
      AppConstant.KisHijri = false;
    }
  }

  static void removeSplash() {
    try {
      FlutterNativeSplash.remove();
    } catch (e) {
      print('Error removing splash: $e');
    }
  }
}

