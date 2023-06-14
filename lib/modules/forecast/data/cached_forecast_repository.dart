import '../../network/cache_handler.dart';
import '../domain/repositories/forecast_model.dart';
import '../domain/repositories/forecast_repositories.dart';

final class CachedForecastRepository implements ForecastRepository {
  const CachedForecastRepository(
    this._decorated,
    this._cacheHandler,
  );
  final ForecastRepository _decorated;
  final CacheHandler _cacheHandler;

  @override
  Future<ForecastModel> fetchForecast({required double lat, required double long}) {
    return _cacheHandler.fetch(
      onFetch: () => _decorated.fetchForecast(lat: lat, long: long),
      storeKey: 'forecast',
    );
  }
}
