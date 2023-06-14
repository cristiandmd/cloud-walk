import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

enum AppRoutesNames { concerts, concertsDetail, notFound }

abstract class AppRoute {
  AppRoutesNames get type;
  Route<T> handle<T>(RouteSettings settings);
}

final class NotFoundPageRoute extends AppRoute {
  @override
  AppRoutesNames get type => AppRoutesNames.notFound;

  @override
  Route<T> handle<T>(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        key: const Key('not-found-widget'),
        body: Center(
          child: Text(S.current.RouteNotFound),
        ),
      ),
    );
  }
}
