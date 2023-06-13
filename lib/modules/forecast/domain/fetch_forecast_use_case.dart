import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_repositories.dart';

import 'repositories/forecast_model.dart';

final class FetchForecastUseCase {
  const FetchForecastUseCase({
    required ForecastRepository forecastFiveDaysRepository,
  }) : _forecastFiveDaysRepository = forecastFiveDaysRepository;
  final ForecastRepository _forecastFiveDaysRepository;

  Future<ForecastModel> call({
    required double lat,
    required double long,
    required ForecastRange range,
  }) =>
      switch (range) {
        ForecastRange.nextFiveDays => _forecastFiveDaysRepository.fetchForecast(lat: lat, long: long),
      };
}
