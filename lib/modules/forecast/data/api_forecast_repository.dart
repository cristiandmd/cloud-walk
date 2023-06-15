import 'dart:convert';

import 'package:concerts_weather/api_keys.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_repositories.dart';
import 'package:concerts_weather/modules/shared/mappers.dart';
import 'package:http/http.dart';

final class ApiForecastRepository implements ForecastRepository {
  const ApiForecastRepository(this._client);
  final Client _client;

  @override
  Future<ForecastModel> fetchForecast({
    required double latitude,
    required double longitude,
  }) async {
    final url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$openWeatherApiKey';
    final response = await _client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final json = response.body.map(jsonDecode);
      final items = (json['list'] as List<dynamic>).map((data) => data['weather'][0]).toList();

      return ForecastModel.fromJson({'weathers': items});
    } else {
      throw CouldNotFetchForecast();
    }
  }
}

class CouldNotFetchForecast extends Error {}
