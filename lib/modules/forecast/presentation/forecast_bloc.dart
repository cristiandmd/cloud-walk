import 'package:bloc/bloc.dart';
import 'package:concerts_weather/modules/forecast/domain/fetch_forecast_use_case.dart';

import 'forecast_events.dart';
import 'forecast_state.dart';

class ForecastBloc extends Bloc<ForecastEvent, ForecastState> {
  ForecastBloc(FetchForecastUseCase fetchForecast) : super(InitialForecastState()) {
    on<LoadForecastEvent>((event, emit) async {
      emit(LoadingForecastState());
      await fetchForecast(
        latitude: event.latitude,
        longitude: event.longitude,
        range: event.range,
      ).then((value) => LoadedForecastState(value)).then(emit).catchError((_, __) {
        emit(CouldNotLoadForecastState());
      });
    });
  }
}
