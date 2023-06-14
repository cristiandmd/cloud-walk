import 'package:concerts_weather/modules/current_weather/data/api_weather_repository.dart';
import 'package:concerts_weather/modules/current_weather/data/cached_weather_repository.dart';
import 'package:concerts_weather/modules/current_weather/domain/fetch_weather_use_case.dart';
import 'package:concerts_weather/modules/network/cache_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import 'presentation/current_weather.dart';
import 'presentation/current_weather_bloc.dart';

final class CurrentWeatherFactory {
  const CurrentWeatherFactory(this._client, this._cacheHandler);
  final Client _client;
  final CacheHandler _cacheHandler;

  Widget build({required double latitude, required double longitude}) {
    final apiRepository = APIWeatherRepository(_client);
    final cachedRepository = CachedWeatherRepository(apiRepository, _cacheHandler);
    final useCase = FetchWeatherUseCase(repository: cachedRepository);
    final bloc = CurrentWeatherBloc(useCase);
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => bloc)],
      child: CurrentWeather(
        bloc: bloc,
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }
}
