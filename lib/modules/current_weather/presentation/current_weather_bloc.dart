import 'package:bloc/bloc.dart';
import 'package:concerts_weather/modules/current_weather/domain/fetch_weather_use_case.dart';

import 'current_weather_events.dart';
import 'current_weather_state.dart';

class CurrentWeatherBloc extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  CurrentWeatherBloc(FetchWeatherUseCase fetchWeatherUseCase) : super(InitialCurrentWeatherState()) {
    on<LoadCurrentWeatherEvent>((event, emit) async {
      emit(LoadingCurrentWeatherState());
      await fetchWeatherUseCase(latitude: event.latitude, longitude: event.longitude)
          .then((value) => LoadedCurrentWeatherState(value))
          .then(emit)
          .catchError((_) => emit(ColdNotLoadCurrentWeatherState()));
    });
  }
}
