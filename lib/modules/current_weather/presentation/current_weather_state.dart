import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';

sealed class CurrentWeatherState {}

final class InitialCurrentWeatherState extends CurrentWeatherState {}

final class LoadingCurrentWeatherState extends CurrentWeatherState {}

final class LoadedCurrentWeatherState extends CurrentWeatherState {
  LoadedCurrentWeatherState(this.data);
  final WeatherModel data;
}

final class ColdNotLoadCurrentWeatherState extends CurrentWeatherState {}
