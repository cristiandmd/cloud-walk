import 'weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> fetchWeather({
    required double latitude,
    required double longitude,
  });
}
