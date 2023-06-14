import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_repositories.dart';

import 'repositories/forecast_model.dart';

final class FetchForecastUseCase {
  const FetchForecastUseCase({
    required ForecastRepository forecastFiveDaysRepository,
  }) : _forecastFiveDaysRepository = forecastFiveDaysRepository;
  final ForecastRepository _forecastFiveDaysRepository;

  Future<ForecastModel> call({
    required double latitude,
    required double longitude,
    required ForecastRange range,
  }) =>
      switch (range) {
        ForecastRange.nextFiveDays => _forecastFiveDaysRepository.fetchForecast(
            latitude: latitude,
            longitude: longitude,
          ),
      };
}
