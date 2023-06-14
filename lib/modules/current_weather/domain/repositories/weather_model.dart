import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  factory WeatherModel.fromJson(Map<String, dynamic> json) => const WeatherModel();
  Map<String, dynamic> toJson() => {};
  const WeatherModel();

  @override
  List<Object?> get props => [];
}
