import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static const _keyFirstTime = 'first_time';

  Future<void> setFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyFirstTime, false);
  }

  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyFirstTime) ?? true;
  }
}
