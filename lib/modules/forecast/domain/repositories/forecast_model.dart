import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';
import 'package:equatable/equatable.dart';

class ForecastModel extends Equatable {
  const ForecastModel(this.weathers);
  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final items = (json['weathers'] as List<dynamic>);
    return ForecastModel(items.map((data) => WeatherModel.fromJson(data)).toList());
  }
  Map<String, dynamic> toJson() => {'weathers': weathers.map((e) => e.toJson()).toList()};

  final List<WeatherModel> weathers;

  @override
  List<Object?> get props => [weathers];
}

enum ForecastRange { nextFiveDays }
