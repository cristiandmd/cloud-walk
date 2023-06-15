import 'dart:convert';

import 'package:concerts_weather/api_keys.dart';
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';
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
  const latitude = 20.0;
  const longitude = 20.0;
  const url = 'https://api.openweathermap.org/data/2.5/forecast?lat=$latitude&lon=$longitude&appid=$openWeatherApiKey';
  group('#fetchForecast', () {
    test('when the status is 200 then returns the data', () async {
      final clientMock = MockClient();
      final jsonResponse = {
        'list': [
          {
            'weather': [
              {
                'description': 'Foo',
                'main': 'Bar',
              }
            ]
          },
        ]
      };
      when(clientMock.get(Uri.parse(url))).thenAnswer((_) async => Response(jsonEncode(jsonResponse), 200));
      final sut = makeSUT(clientMock);
      expect(
        sut.fetchForecast(latitude: latitude, longitude: longitude),
        completion(const ForecastModel([WeatherModel(description: 'Foo', main: 'Bar')])),
      );
    });
    test('when the status is not 200 then throws CouldNotFetchWeather', () async {
      final clientMock = MockClient();
      when(clientMock.get(any)).thenAnswer((_) async => Response('', 400));
      final sut = makeSUT(clientMock);

      expect(
        sut.fetchForecast(latitude: latitude, longitude: longitude),
        throwsA(isA<CouldNotFetchForecast>()),
      );
    });
  });
}

ForecastRepository makeSUT(Client client) {
  return ApiForecastRepository(client);
}
