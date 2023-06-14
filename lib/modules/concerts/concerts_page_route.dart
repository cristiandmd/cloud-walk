import 'package:concerts_weather/app/routes/app_route.dart';
import 'package:concerts_weather/modules/concerts/concerts_factory.dart';
import 'package:flutter/material.dart';

final class ConcertsPageRoute implements AppRoute {
  const ConcertsPageRoute(this._concertsFactory);
  final ConcertsFactory _concertsFactory;

  @override
  Route<T> handle<T>(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => _concertsFactory.build(),
    );
  }

  @override
  AppRoutesNames get type => AppRoutesNames.concerts;
}
