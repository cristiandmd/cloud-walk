import 'package:concerts_weather/app/routes/app_route.dart';
import 'package:concerts_weather/app/routes/build_routes.dart';
import 'package:concerts_weather/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

const _navigatorKey = Key('navigator');

extension Tester on WidgetTester {
  Future<void> pumpSUT({
    required Iterable<AppRoute> routes,
    NavigatorObserver? observer,
  }) async {
    await pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        navigatorObservers: [if (observer != null) observer],
        onGenerateRoute: buildRoutes(routes),
        home: const SizedBox(key: _navigatorKey),
      ),
    );
    await pumpAndSettle();
  }

  void navigateTo(String routeName) {
    final context = element(find.byKey(_navigatorKey));
    Navigator.of(context).pushNamed(routeName);
  }
}
