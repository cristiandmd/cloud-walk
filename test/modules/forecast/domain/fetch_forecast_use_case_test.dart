import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<ForecastRepository>()])
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_repositories.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';
import 'package:concerts_weather/modules/forecast/domain/fetch_forecast_use_case.dart';

import 'fetch_forecast_use_case_test.mocks.dart';

void main() {
  group('#fetchForecast', () {
    test('when succeed then returns properly', () async {
      final repositoryMock = MockForecastRepository();
      const forecast = ForecastModel();
      const lat = 200.0;
      const long = 400.0;
      when(repositoryMock.fetchForecast(lat: lat, long: long)).thenAnswer((_) async => forecast);
      final fetchForecast = makeSUT(repositoryMock);

      expect(
        fetchForecast(lat: lat, long: long, range: ForecastRange.nextFiveDays),
        completion(forecast),
      );
    });

    test('when fails then throw error', () async {
      final repositoryMock = MockForecastRepository();
      const lat = 200.0;
      const long = 400.0;
      when(repositoryMock.fetchForecast(lat: lat, long: long)).thenAnswer((_) => Future.error(Exception()));
      final fetchForecast = makeSUT(repositoryMock);

      expect(
        fetchForecast(lat: lat, long: long, range: ForecastRange.nextFiveDays),
        throwsException,
      );
    });
  });
}

FetchForecastUseCase makeSUT(ForecastRepository repository) {
  return FetchForecastUseCase(forecastFiveDaysRepository: repository);
}
