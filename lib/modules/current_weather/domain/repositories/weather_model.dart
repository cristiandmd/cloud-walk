import 'package:equatable/equatable.dart';

class WeatherModel extends Equatable {
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: json['description'],
      main: json['main'],
    );
  }

  const WeatherModel({
    required this.description,
    required this.main,
  });

  final String description;
  final String main;

  Map<String, dynamic> toJson() => {
        'description': description,
        'main': main,
      };

  @override
  List<Object?> get props => [description, main];
}
