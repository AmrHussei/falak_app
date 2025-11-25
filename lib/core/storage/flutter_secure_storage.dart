import 'package:falak/core/utils/app_logger.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SecureStorageServices {
  static SecureStorageServices? _instance;

  static const String _boxName = "secure_storage";
  static const String cookieToken = "cookie";

  Box? _box;
  String? _cookie;

  Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox(_boxName);
  }

  SecureStorageServices._();

  factory SecureStorageServices() {
    return _instance ??= SecureStorageServices._();
  }

  Future<void> setCookie({required String? cookie}) async {
    try {
      await _box?.put(cookieToken, cookie);
      _cookie = cookie;
    } catch (e) {
      AppLogger.error('Error writing cookie: $e');
      await _resetStorage();
    }
  }

  Future<void> deleteCookie() async {
    try {
      await _box?.delete(cookieToken);
      _cookie = null;
    } catch (e) {
      AppLogger.error('Error deleting cookie: $e');
      await _resetStorage();
    }
  }

  Future<String?> getCookie() async {
    try {
      _cookie = _box?.get(cookieToken);
      AppLogger.debug('getCookie: $_cookie');
      return _cookie;
    } catch (e) {
      AppLogger.error('Error reading cookie: $e');
      await _resetStorage();
      return null;
    }
  }

  Future<void> _resetStorage() async {
    try {
      await _box?.clear();
      _cookie = null;
      AppLogger.warning('Storage has been reset');
    } catch (e) {
      AppLogger.error('Error resetting storage: $e');
    }
  }

  set cookie(String? cookie) {
    _cookie = cookie;
  }

  String? get cookie {
    return _cookie;
  }
}
