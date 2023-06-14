import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';
import 'package:equatable/equatable.dart';

class ForecastModel extends Equatable {
  const ForecastModel(this.weathers);
  factory ForecastModel.fromJson(Map<String, dynamic> json) => ForecastModel(
        (json['list'] as List<dynamic>).whereType<Map<String, dynamic>>().map(WeatherModel.fromJson),
      );
  Map<String, dynamic> toJson() => {'list': weathers};

  final Iterable<WeatherModel> weathers;

  @override
  List<Object?> get props => [];
}

enum ForecastRange { nextFiveDays }
