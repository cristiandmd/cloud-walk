import 'package:concerts_weather/app/routes/app_route.dart';
import 'package:concerts_weather/modules/concerts/domain/repositories/concert_model.dart';
import 'package:concerts_weather/modules/current_weather/current_weather_factory.dart';
import 'package:concerts_weather/modules/forecast/domain/repositories/forecast_model.dart';
import 'package:concerts_weather/modules/forecast/forecast_factory.dart';
import 'package:flutter/material.dart';

import 'presentation/concerts_detail_page.dart';

final class ConcertsDetailPageRoute implements AppRoute {
  const ConcertsDetailPageRoute(this._currentWeatherFactory, this._forecastFactory);
  final CurrentWeatherFactory _currentWeatherFactory;
  final ForecastFactory _forecastFactory;

  @override
  Route<T> handle<T>(RouteSettings settings) {
    return MaterialPageRoute(builder: (_) {
      final concerts = settings.arguments as ConcertModel;
      return ConcertsDetailPage(
        currentWeather: (_) => _currentWeatherFactory.build(
          latitude: concerts.address.latitude,
          longitude: concerts.address.longitude,
        ),
        forecast: (_) => _forecastFactory.build(
          latitude: concerts.address.latitude,
          longitude: concerts.address.longitude,
          range: ForecastRange.nextFiveDays,
        ),
        concert: concerts,
      );
    });
  }

  @override
  AppRoutesNames get type => AppRoutesNames.concertsDetail;
}
