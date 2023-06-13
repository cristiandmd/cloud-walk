import 'package:flutter/material.dart';

import 'app_route.dart';

final appRoutes = <AppRoute>[];

Route<dynamic>? Function(RouteSettings) buildRoutes(Iterable<AppRoute> routes) {
  return (settings) {
    return routes
        .firstWhere(
          (route) => route.type.name == settings.name,
          orElse: () => NotFoundPageRoute(),
        )
        .handle(settings);
  };
}
