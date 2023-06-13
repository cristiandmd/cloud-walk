import 'repositories/concert_model.dart';
import 'repositories/concerts_repository.dart';

final class FetchConcertsUseCase {
  FetchConcertsUseCase({
    required ConcertsRepository repository,
  }) : _repository = repository;
  final ConcertsRepository _repository;

  Future<Iterable<ConcertModel>> call() => _repository.fetchConcerts();
}
