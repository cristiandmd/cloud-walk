import 'dart:convert';

import 'package:concerts_weather/api_keys.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_repositories.dart';
import 'package:http/http.dart';

final class ApiForecastRepository implements ForecastRepository {
  const ApiForecastRepository(this._client);
  final Client _client;

  @override
  Future<ForecastModel> fetchForecast({required double lat, required double long}) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?lat={$lat}&lon={$long}&appid={$openWeatherApiKey}';
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return ForecastModel.fromJson(json);
    } else {
      throw CouldNotFetchForecast();
    }
  }
}

class CouldNotFetchForecast extends Error {}
