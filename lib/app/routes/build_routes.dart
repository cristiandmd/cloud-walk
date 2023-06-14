import 'package:concerts_weather/modules/concerts/concerts_factory.dart';
import 'package:concerts_weather/modules/concerts/concerts_page_route.dart';
import 'package:concerts_weather/modules/concerts_detail/concerts_detail_route.dart';
import 'package:concerts_weather/modules/current_weather/current_weather_factory.dart';
import 'package:concerts_weather/modules/forecast/forecast_factory.dart';
import 'package:concerts_weather/modules/network/cache_handler.dart';
import 'package:concerts_weather/modules/network/connectivity_detector.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_route.dart';

final dependencies = [];

// TODO(refactor): we should improve D.I
Iterable<AppRoute> appRoutes() {
  final client = Client();
  final connectivityDetector = BaseConnectivityDetector(Connectivity());
  final cacheHandler = SharedPreferencesCacheHandler(
    connectivityDetector: connectivityDetector,
    sharedPreferences: SharedPreferences.getInstance,
  );

  /// Factories
  final concertsFactory = ConcertsFactory();
  final currentWeatherFactory = CurrentWeatherFactory(client, cacheHandler);
  final forecastFactory = ForecastFactory(client, cacheHandler);

  return [
    ConcertsPageRoute(concertsFactory),
    ConcertsDetailPageRoute(currentWeatherFactory, forecastFactory),
  ];
}

Route<dynamic>? Function(RouteSettings) buildRoutes(Iterable<AppRoute> routes) {
  return (settings) {
    return routes.firstWhere(
      (route) {
        return route.type.name == settings.name;
      },
      orElse: () => NotFoundPageRoute(),
    ).handle(settings);
  };
}
