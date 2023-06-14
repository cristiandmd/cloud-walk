import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';

sealed class ForecastEvent {}

class LoadForecastEvent extends ForecastEvent {
  LoadForecastEvent({
    required this.latitude,
    required this.longitude,
    required this.range,
  });
  final double latitude, longitude;
  final ForecastRange range;
}
