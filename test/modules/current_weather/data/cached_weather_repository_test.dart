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
  const lat = 200.0;
  const long = 400.0;
  const model = WeatherModel();
  const storageKey = 'weather';

  group('#fetchForecast', () {
    test('when cache handler throws error then rethrows', () async {
      final repositoryMock = MockWeatherRepository();
      when(repositoryMock.fetchWeather(lat: lat, long: long)).thenAnswer((_) => Future.error(Exception()));
      final cacheHandler = MockCacheHandler();
      when(
        cacheHandler.fetch(
          onFetch: anyNamed('onFetch'),
          storeKey: storageKey,
        ),
      ).thenAnswer((invocation) {
        expect(
          invocation.callFetch(),
          throwsException,
        );
        return Future<WeatherModel>.error(Exception());
      });
      final sut = makeSUT(repositoryMock, cacheHandler);

      expect(sut.fetchWeather(lat: lat, long: long), throwsException);
      verify(repositoryMock.fetchWeather(lat: lat, long: long)).called(1);
    });

    test('when cache handler succeed then returns data', () async {
      final repositoryMock = MockWeatherRepository();
      when(repositoryMock.fetchWeather(lat: lat, long: long)).thenAnswer((_) async => model);
      final cacheHandler = MockCacheHandler();
      when(cacheHandler.fetch(
        onFetch: anyNamed('onFetch'),
        storeKey: storageKey,
      )).thenAnswer((invocation) async {
        invocation.callFetch();
        return model;
      });
      final sut = makeSUT(repositoryMock, cacheHandler);

      expect(sut.fetchWeather(lat: lat, long: long), completion(model));
      verify(repositoryMock.fetchWeather(lat: lat, long: long)).called(1);
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
