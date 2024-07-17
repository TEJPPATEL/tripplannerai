import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tripplannerai/models/itinerary_model.dart';

class ItineraryService {
  Future<ItineraryResult> getItineraryData(
      {city, start_date, end_date, activities}) async {
    final String reqURL = 'https://trip-plan-api.onrender.com/trip-plan?city=$city&start_date=$start_date&end_date=$end_date&activites=$activities';
    final uri = Uri.parse(reqURL);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      final itineraryResult = ItineraryResult.fromJson(responseBody['res']);
      return itineraryResult;
    } else {
      throw ("Failed to load Itinerary");
    }

    // final dynamic response = await rootBundle.loadString(reqURL);
    // final Map<String, dynamic> result = jsonDecode(response);
    // final ItineraryRes itineraryRes = ItineraryRes.fromJson(result['res']);
    // return itineraryRes;
  }
  
}
