import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:concerts_weather/modules/forecast/data/cached_forecast_repository.dart';
@GenerateNiceMocks([MockSpec<ForecastRepository>()])
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_repositories.dart';
@GenerateNiceMocks([MockSpec<CacheHandler>()])
import 'package:concerts_weather/modules/network/cache_handler.dart';

import 'cached_forecast_repository_test.mocks.dart';

void main() {
  const latitude = 200.0;
  const longitude = 400.0;
  const model = ForecastModel();
  const storageKey = 'forecast-$latitude-$longitude';
  group('#fetchForecast', () {
    test('when cache handler throws error then rethrows', () async {
      final repositoryMock = MockForecastRepository();
      final cacheHandler = MockCacheHandler();
      when(repositoryMock.fetchForecast(latitude: latitude, longitude: longitude))
          .thenAnswer((_) => Future.error(Exception()));
      when(
        cacheHandler.fetch(
          onFetch: anyNamed('onFetch'),
          storeKey: storageKey,
          map: ForecastModel.fromJson,
        ),
      ).thenAnswer((invocation) {
        expect(
          invocation.callFetch(),
          throwsException,
        );
        return Future<ForecastModel>.error(Exception());
      });
      final sut = makeSUT(repositoryMock, cacheHandler);

      expect(
        sut.fetchForecast(latitude: latitude, longitude: longitude),
        throwsException,
      );
      verify(repositoryMock.fetchForecast(latitude: latitude, longitude: longitude)).called(1);
    });

    test('when cache handler succeed then returns data', () async {
      final repositoryMock = MockForecastRepository();
      final cacheHandler = MockCacheHandler();
      when(repositoryMock.fetchForecast(latitude: latitude, longitude: longitude)).thenAnswer((_) async => model);
      when(
        cacheHandler.fetch(
          onFetch: anyNamed('onFetch'),
          storeKey: storageKey,
          map: ForecastModel.fromJson,
        ),
      ).thenAnswer((invocation) async {
        invocation.callFetch();
        return model;
      });
      final sut = makeSUT(repositoryMock, cacheHandler);

      expect(
        sut.fetchForecast(latitude: latitude, longitude: longitude),
        completion(model),
      );
      verify(repositoryMock.fetchForecast(latitude: latitude, longitude: longitude)).called(1);
    });
  });
}

ForecastRepository makeSUT(ForecastRepository repository, CacheHandler cacheHandler) {
  return CachedForecastRepository(repository, cacheHandler);
}

extension _Mapper on Invocation {
  Future<ForecastModel> callFetch() async {
    final fn = namedArguments[const Symbol('onFetch')] as Function();
    return fn();
  }
}
