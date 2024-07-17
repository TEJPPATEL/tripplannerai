import 'dart:convert';
import 'package:tripplannerai/models/city_model.dart';
import 'package:tripplannerai/services/shared_preference_service.dart';
import 'package:tripplannerai/utilites/city_service.dart';
import 'package:tripplannerai/utilites/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isFirstLunchApp() async {
  // return true;
  final isFirstLunch = await SharedPreferencesService()
      .getBoolFromSharePreferences(StorageKeys.isFirstLunch);
  return isFirstLunch == null || isFirstLunch;
}

void getCities() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? isCitiesRes = prefs.getStringList(StorageKeys.citiesRes);
  if (isCitiesRes == null) {
    List<City> cities = await CityService().getCities();
    final List<String> cityList =
        cities.map((e) => jsonEncode(e.toMap())).toList();
    prefs.setStringList(StorageKeys.citiesRes, cityList);
  }
}
