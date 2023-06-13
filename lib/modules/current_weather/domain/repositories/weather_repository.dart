import 'weather_model.dart';

abstract class WeatherRepository {
  Future<WeatherModel> fetchWeather({required double lat, required double long});
}
