import 'package:concerts_weather/modules/forecast/data/api_forecast_repository.dart';
import 'package:concerts_weather/modules/forecast/data/cached_forecast_repository.dart';
import 'package:concerts_weather/modules/forecast/domain/fetch_forecast_use_case.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../network/cache_handler.dart';
import 'presentation/forecast.dart';
import 'presentation/forecast_bloc.dart';

final class ForecastFactory {
  const ForecastFactory(this._client, this._cacheHandler);
  final Client _client;
  final CacheHandler _cacheHandler;

  Widget build({
    required double latitude,
    required double longitude,
    required ForecastRange range,
  }) {
    final apiRepository = ApiForecastRepository(_client);
    final cachedRepository = CachedForecastRepository(apiRepository, _cacheHandler);
    final useCase = FetchForecastUseCase(forecastFiveDaysRepository: cachedRepository);
    final bloc = ForecastBloc(useCase);
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => bloc)],
      child: Forecast(
        bloc: bloc,
        latitude: latitude,
        longitude: longitude,
        range: range,
      ),
    );
  }
}
