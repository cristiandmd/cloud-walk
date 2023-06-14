import 'dart:convert';

import 'package:concerts_weather/modules/current_weather/data/api_weather_repository.dart';
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<Client>()])
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_repository.dart';
import 'api_weather_repository_test.mocks.dart';

void main() {
  const lat = 20.0;
  const long = 20.0;
  group('#fetchWeather', () {
    test('when the status is 200 then returns the data', () async {
      final clientMock = MockClient();
      const model = WeatherModel();
      when(clientMock.get(any)).thenAnswer((_) async => Response(jsonEncode(model), 200));
      final sut = makeSUT(clientMock);

      expect(
        sut.fetchWeather(lat: lat, long: long),
        completion(model),
      );
    });
    test('when the status is not 200 then throws CouldNotFetchWeather', () async {
      final clientMock = MockClient();
      when(clientMock.get(any)).thenAnswer((_) async => Response('', 400));
      final sut = makeSUT(clientMock);

      expect(
        sut.fetchWeather(lat: lat, long: long),
        throwsA(isA<CouldNotFetchWeather>()),
      );
    });
  });
}

WeatherRepository makeSUT(Client client) {
  return APIWeatherRepository(client);
}
