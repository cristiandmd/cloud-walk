import '../../network/cache_handler.dart';
import '../domain/repositories/weather_model.dart';
import '../domain/repositories/weather_repository.dart';

final class CachedWeatherRepository implements WeatherRepository {
  const CachedWeatherRepository(
    this._decorated,
    this._cacheHandler,
  );
  final WeatherRepository _decorated;
  final CacheHandler _cacheHandler;

  @override
  Future<WeatherModel> fetchWeather({required double latitude, required double longitude}) async {
    return _cacheHandler.fetch(
      onFetch: () => _decorated.fetchWeather(latitude: latitude, longitude: longitude),
      map: WeatherModel.fromJson,
      storeKey: 'weather-$latitude-$longitude',
    );
  }
}
