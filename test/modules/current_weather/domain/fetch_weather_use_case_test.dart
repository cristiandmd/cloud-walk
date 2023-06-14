import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:concerts_weather/modules/current_weather/domain/fetch_weather_use_case.dart';
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_repository.dart';
import 'fetch_weather_use_case_test.mocks.dart';

void main() {
  const latitude = 200.0;
  const longitude = 400.0;
  group('#fetchWeather', () {
    test('when succeed then returns properly', () async {
      final repositoryMock = MockWeatherRepository();
      const weather = WeatherModel(description: 'foo', main: 'bar');
      when(repositoryMock.fetchWeather(latitude: latitude, longitude: longitude)).thenAnswer((_) async => weather);
      final fetchWeather = makeSUT(repositoryMock);

      expect(fetchWeather(latitude: latitude, longitude: longitude), completion(weather));
    });

    test('when fails then throw error', () async {
      final repositoryMock = MockWeatherRepository();

      when(repositoryMock.fetchWeather(latitude: latitude, longitude: longitude))
          .thenAnswer((_) => Future.error(Exception()));
      final fetchWeather = makeSUT(repositoryMock);

      expect(fetchWeather(latitude: latitude, longitude: longitude), throwsException);
    });
  });
}

FetchWeatherUseCase makeSUT(WeatherRepository repository) {
  return FetchWeatherUseCase(repository: repository);
}
