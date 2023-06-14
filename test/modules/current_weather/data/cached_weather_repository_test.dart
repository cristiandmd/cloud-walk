import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:concerts_weather/modules/current_weather/data/cached_weather_repository.dart';
@GenerateNiceMocks([MockSpec<WeatherRepository>()])
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_repository.dart';
@GenerateNiceMocks([MockSpec<CacheHandler>()])
import 'package:concerts_weather/modules/network/cache_handler.dart';
import 'cached_weather_repository_test.mocks.dart';

void main() {
  const latitude = 200.0;
  const longitude = 400.0;
  const model = WeatherModel(description: 'foo', main: 'bar');
  const storageKey = 'weather-$latitude-$longitude';

  group('#fetchForecast', () {
    test('when cache handler throws error then rethrows', () async {
      final repositoryMock = MockWeatherRepository();
      when(repositoryMock.fetchWeather(latitude: latitude, longitude: longitude))
          .thenAnswer((_) => Future.error(Exception()));
      final cacheHandler = MockCacheHandler();
      when(
        cacheHandler.fetch(
          onFetch: anyNamed('onFetch'),
          storeKey: storageKey,
          map: WeatherModel.fromJson,
        ),
      ).thenAnswer((invocation) {
        expect(
          invocation.callFetch(),
          throwsException,
        );
        return Future<WeatherModel>.error(Exception());
      });
      final sut = makeSUT(repositoryMock, cacheHandler);

      expect(sut.fetchWeather(latitude: latitude, longitude: longitude), throwsException);
      verify(repositoryMock.fetchWeather(latitude: latitude, longitude: longitude)).called(1);
    });

    test('when cache handler succeed then returns data', () async {
      final repositoryMock = MockWeatherRepository();
      when(repositoryMock.fetchWeather(latitude: latitude, longitude: longitude)).thenAnswer((_) async => model);
      final cacheHandler = MockCacheHandler();
      when(
        cacheHandler.fetch(
          onFetch: anyNamed('onFetch'),
          storeKey: storageKey,
          map: WeatherModel.fromJson,
        ),
      ).thenAnswer((invocation) async {
        invocation.callFetch();
        return model;
      });
      final sut = makeSUT(repositoryMock, cacheHandler);

      expect(sut.fetchWeather(latitude: latitude, longitude: longitude), completion(model));
      verify(repositoryMock.fetchWeather(latitude: latitude, longitude: longitude)).called(1);
    });
  });
}

WeatherRepository makeSUT(WeatherRepository repository, CacheHandler cacheHandler) {
  return CachedWeatherRepository(repository, cacheHandler);
}

extension _Mapper on Invocation {
  Future<WeatherModel> callFetch() async {
    final fn = namedArguments[const Symbol('onFetch')] as Function();
    return fn();
  }
}
