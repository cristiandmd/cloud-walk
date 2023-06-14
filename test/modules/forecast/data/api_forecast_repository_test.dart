import 'dart:convert';

import 'package:concerts_weather/modules/forecast/data/api_forecast_repository.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_repositories.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'api_forecast_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Client>()])
void main() {
  const lat = 20.0;
  const long = 20.0;
  group('#fetchForecast', () {
    test('when the status is 200 then returns the data', () async {
      final clientMock = MockClient();
      const model = ForecastModel();
      when(clientMock.get(any)).thenAnswer((_) async => Response(jsonEncode(model), 200));
      final sut = makeSUT(clientMock);

      expect(
        sut.fetchForecast(lat: lat, long: long),
        completion(model),
      );
    });
    test('when the status is not 200 then throws CouldNotFetchWeather', () async {
      final clientMock = MockClient();
      when(clientMock.get(any)).thenAnswer((_) async => Response('', 400));
      final sut = makeSUT(clientMock);

      expect(
        sut.fetchForecast(lat: lat, long: long),
        throwsA(isA<CouldNotFetchForecast>()),
      );
    });
  });
}

ForecastRepository makeSUT(Client client) {
  return ApiForecastRepository(client);
}
