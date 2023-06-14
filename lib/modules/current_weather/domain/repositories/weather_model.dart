import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  const WeatherModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {};
  const WeatherModel();

  @override
  List<Object?> get props => [];
}
