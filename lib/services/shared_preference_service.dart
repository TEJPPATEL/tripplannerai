import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  addStringToSharePreferences(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  addStringListToSharePreferences(String key, List<String> list) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(key, list);
  }

  addBoolToSharePreferences(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  getStringFromSharePreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString(key);
  }

  Future<bool?> getBoolFromSharePreferences(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }
}
