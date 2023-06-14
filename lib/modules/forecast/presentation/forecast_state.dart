import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';

sealed class ForecastState {}

final class InitialForecastState extends ForecastState {}

final class LoadingForecastState extends ForecastState {}

final class LoadedForecastState extends ForecastState {
  LoadedForecastState(this.data);
  final ForecastModel data;
}

final class CouldNotLoadForecastState extends ForecastState {}
