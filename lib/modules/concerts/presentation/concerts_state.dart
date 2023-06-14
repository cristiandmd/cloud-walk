import 'package:concerts_weather/modules/concerts/domain/repositories/concert_model.dart';

sealed class ConcertsState {}

final class InitialConcertsState extends ConcertsState {}

final class LoadingConcertsState extends ConcertsState {}

final class LoadedConcertsState extends ConcertsState {
  LoadedConcertsState(this.data);
  final Iterable<ConcertModel> data;
}

final class ColdNotLoadConcertsState extends ConcertsState {}
