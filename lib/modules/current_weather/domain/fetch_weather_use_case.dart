import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';

import 'repositories/weather_repository.dart';

final class FetchWeatherUseCase {
  FetchWeatherUseCase({
    required WeatherRepository repository,
  }) : _repository = repository;
  final WeatherRepository _repository;

  Future<WeatherModel> call({required double lat, required double long}) => _repository.fetchWeather(
        lat: lat,
        long: long,
      );
}
