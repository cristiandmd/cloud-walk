import 'package:concerts_weather/modules/concerts/data/in_memory_concerts_repository.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/address_model.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/concert_model.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/concerts_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('#fetchForecast returns data properly', () async {
    final sut = makeSUT();

    expect(
      sut.fetchConcerts(),
      completion(
        const [
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
        ],
      ),
    );
  });
}

ConcertsRepository makeSUT() {
  return InMemoryConcertsRepository();
}
