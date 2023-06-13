import 'concert.dart';

abstract class ConcertsRepository {
  Future<Iterable<Concert>> fetchConcerts();
}
