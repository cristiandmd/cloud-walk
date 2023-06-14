import 'dart:convert';

import 'package:concerts_weather/api_keys.dart';
import 'package:http/http.dart';

import '../domain/repositories/weather_model.dart';
import '../domain/repositories/weather_repository.dart';

final class APIWeatherRepository implements WeatherRepository {
  const APIWeatherRepository(this._client);
  final Client _client;

  @override
  Future<WeatherModel> fetchWeather({required double lat, required double long}) async {
    final url = 'https://api.openweathermap.org/data/2.5/weather?lat={$lat}&lon={$long}&appid={$openWeatherApiKey}';
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body) as Map<String, dynamic>;
      return WeatherModel.fromJson(json);
    } else {
      throw CouldNotFetchWeather();
    }
  }
}

class CouldNotFetchWeather extends Error {}
