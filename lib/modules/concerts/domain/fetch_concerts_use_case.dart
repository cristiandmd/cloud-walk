import 'repositories/concert.dart';
import 'repositories/concerts_repository.dart';

final class FetchConcertsUseCase {
  FetchConcertsUseCase({required ConcertsRepository repository}) : _repository = repository;
  final ConcertsRepository _repository;

  Future<Iterable<Concert>> call() => _repository.fetchConcerts();
}
