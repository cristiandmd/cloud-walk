import 'concert_model.dart';

abstract class ConcertsRepository {
  Future<Iterable<ConcertModel>> fetchConcerts();
}
