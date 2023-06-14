import 'package:bloc/bloc.dart';
import 'package:concerts_weather/modules/concerts/domain/fetch_concerts_use_case.dart';

import 'concerts_events.dart';
import 'concerts_state.dart';

class ConcertsBloc extends Bloc<ConcertsEvent, ConcertsState> {
  ConcertsBloc(FetchConcertsUseCase fetchConcertsUseCase) : super(InitialConcertsState()) {
    on<LoadConcertsEvent>((event, emit) async {
      emit(LoadingConcertsState());
      await fetchConcertsUseCase()
          .then((value) => LoadedConcertsState(value))
          .then(emit)
          .catchError((_, __) => emit(ColdNotLoadConcertsState()));
    });
  }
}
