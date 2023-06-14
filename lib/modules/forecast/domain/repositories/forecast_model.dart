import 'package:equatable/equatable.dart';

class ForecastModel extends Equatable {
  const ForecastModel();
  factory ForecastModel.fromJson(Map<String, dynamic> json) => const ForecastModel();
  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];
}

enum ForecastRange { nextFiveDays }
