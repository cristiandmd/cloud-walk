import 'package:equatable/equatable.dart';

class ForecastModel extends Equatable {
  const ForecastModel();
  const ForecastModel.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson() => {};

  @override
  List<Object?> get props => [];
}

enum ForecastRange { nextFiveDays }
