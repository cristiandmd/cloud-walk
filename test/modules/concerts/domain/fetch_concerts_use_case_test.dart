import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:concerts_weather/modules/concerts/domain/fetch_concerts_use_case.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/address_model.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/concert_model.dart';
@GenerateNiceMocks([MockSpec<ConcertsRepository>()])
import 'package:concerts_weather/modules/concerts/domain/repositories/concerts_repository.dart';
import 'fetch_concerts_use_case_test.mocks.dart';

void main() {
  group('#fetchConcerts', () {
    test('when succeed then returns properly', () async {
      final repositoryMock = MockConcertsRepository();
      const concerts = [
        ConcertModel(
          address: AddressModel(
            city: 'Silverstone',
            country: 'UK',
            latitude: 52.073273,
            longitude: -1.014818,
          ),
        ),
        ConcertModel(
          address: AddressModel(
            city: 'São Paulo',
            country: 'Brazil',
            latitude: -23.533773,
            longitude: -46.625290,
          ),
        ),
        ConcertModel(
          address: AddressModel(
            city: 'Melbourne',
            country: 'Australia',
            latitude: -37.840935,
            longitude: 144.946457,
          ),
        ),
        ConcertModel(
          address: AddressModel(
            city: 'Monte Carlo',
            country: 'Monaco',
            latitude: 43.740070,
            longitude: 7.426644,
          ),
        ),
      ];
      when(repositoryMock.fetchConcerts()).thenAnswer((_) async => concerts);
      final fetchConcerts = makeSUT(repositoryMock);

      expect(fetchConcerts(), completion(concerts));
    });

    test('when fails then throw error', () async {
      final repositoryMock = MockConcertsRepository();
      when(repositoryMock.fetchConcerts()).thenAnswer((_) => Future.error(Exception()));
      final fetchConcerts = makeSUT(repositoryMock);

      expect(fetchConcerts(), throwsException);
    });
  });
}

FetchConcertsUseCase makeSUT(ConcertsRepository repository) {
  return FetchConcertsUseCase(repository: repository);
}
