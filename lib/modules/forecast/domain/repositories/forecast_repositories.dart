import 'forecast_model.dart';

abstract class ForecastRepository {
  Future<ForecastModel> fetchForecast({
    required double latitude,
    required double longitude,
  });
}
