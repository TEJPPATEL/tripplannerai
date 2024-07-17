import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:tripplannerai/models/city_model.dart';

class CityService {
   Future<List<City>> getCities() async {
    const String reqURL = 'assets/mock-data/india-cities.json';
    // Uri uri = Uri.parse(reqURL);
    // http.Response response = await http.get(uri);
    final dynamic response = await rootBundle.loadString(reqURL);
    List<dynamic> resBody = jsonDecode(response);
    List<City> cities = resBody.map((body) => City.fromJSON(body)).toList();
    return cities;
  }

  getCityBySearch() {}
}
