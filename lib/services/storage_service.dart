import 'package:shared_preferences/shared_preferences.dart';
import '../core/constants/app_constants.dart';

class StorageService {
  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static SharedPreferences get prefs {
    if (_prefs == null) {
      throw Exception('StorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // 首次启动
  static Future<bool> isFirstLaunch() async {
    return prefs.getBool(AppConstants.keyFirstLaunch) ?? true;
  }

  static Future<void> setFirstLaunchComplete() async {
    await prefs.setBool(AppConstants.keyFirstLaunch, false);
  }

  // 登录状态
  static Future<bool> isLoggedIn() async {
    return prefs.getBool(AppConstants.keyIsLoggedIn) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    await prefs.setBool(AppConstants.keyIsLoggedIn, value);
  }

  // Token
  static String? getToken() {
    return prefs.getString(AppConstants.keyUserToken);
  }

  static Future<void> setToken(String token) async {
    await prefs.setString(AppConstants.keyUserToken, token);
  }

  static Future<void> clearToken() async {
    await prefs.remove(AppConstants.keyUserToken);
  }

  // 清除所有数据（退出登录）
  static Future<void> clearAll() async {
    await prefs.clear();
  }
}
