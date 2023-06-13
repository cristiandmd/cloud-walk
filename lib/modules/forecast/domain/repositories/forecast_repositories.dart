import 'forecast_model.dart';

abstract class ForecastRepository {
  Future<ForecastModel> fetchForecast({
    required double lat,
    required double long,
  });
}
