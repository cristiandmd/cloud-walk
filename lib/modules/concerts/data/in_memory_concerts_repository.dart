import 'package:concerts_weather/modules/concerts/domain/repositories/address_model.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/concert_model.dart';

import '../domain/repositories/concerts_repository.dart';

final class InMemoryConcertsRepository implements ConcertsRepository {
  @override
  Future<Iterable<ConcertModel>> fetchConcerts() async => const [
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
}
