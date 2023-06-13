import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:concerts_weather/modules/current_weather/domain/fetch_weather_use_case.dart';
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_model.dart';

@GenerateNiceMocks([MockSpec<WeatherRepository>()])
import 'package:concerts_weather/modules/current_weather/domain/repositories/weather_repository.dart';
import 'fetch_weather_use_case_test.mocks.dart';

void main() {
  group('#fetchWeather', () {
    test('when succeed then returns properly', () async {
      final repositoryMock = MockWeatherRepository();
      const weather = WeatherModel();
      const lat = 200.0;
      const long = 400.0;
      when(repositoryMock.fetchWeather(lat: lat, long: long)).thenAnswer((_) async => weather);
      final fetchWeather = makeSUT(repositoryMock);

      expect(fetchWeather(lat: lat, long: long), completion(weather));
    });

    test('when fails then throw error', () async {
      final repositoryMock = MockWeatherRepository();
      const lat = 200.0;
      const long = 400.0;
      when(repositoryMock.fetchWeather(lat: lat, long: long)).thenAnswer((_) => Future.error(Exception()));
      final fetchWeather = makeSUT(repositoryMock);

      expect(fetchWeather(lat: lat, long: long), throwsException);
    });
  });
}

FetchWeatherUseCase makeSUT(WeatherRepository repository) {
  return FetchWeatherUseCase(repository: repository);
}
