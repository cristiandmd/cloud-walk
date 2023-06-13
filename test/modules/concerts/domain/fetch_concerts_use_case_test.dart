import 'package:concerts_weather/modules/concerts/domain/fetch_concerts_use_case.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/address.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/concert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([MockSpec<ConcertsRepository>()])
import 'package:concerts_weather/modules/concerts/domain/repositories/concerts_repository.dart';
import 'package:mockito/mockito.dart';
import 'fetch_concerts_use_case_test.mocks.dart';

void main() {
  group('#fetchConcerts', () {
    test('when succeed then returns properly', () async {
      final repositoryMock = MockConcertsRepository();
      const concerts = [
        Concert(address: Address(city: 'Silverstone', country: 'UK', latitude: 52.073273, longitude: -1.014818)),
        Concert(address: Address(city: 'São Paulo', country: 'Brazil', latitude: -23.533773, longitude: -46.625290)),
        Concert(address: Address(city: 'Melbourne', country: 'Australia', latitude: -37.840935, longitude: 144.946457)),
        Concert(address: Address(city: 'Monte Carlo', country: 'Monaco', latitude: 43.740070, longitude: 7.426644)),
      ];
      when(repositoryMock.fetchConcerts()).thenAnswer((_) async => concerts);
      final sut = makeSUT(repositoryMock);

      expect(sut(), completion(concerts));
    });

    test('when fails then throw error', () async {
      final repositoryMock = MockConcertsRepository();
      when(repositoryMock.fetchConcerts()).thenAnswer((_) => Future.error(Exception()));
      final sut = makeSUT(repositoryMock);

      expect(sut(), throwsException);
    });
  });
}

FetchConcertsUseCase makeSUT(ConcertsRepository repository) {
  return FetchConcertsUseCase(repository: repository);
}
