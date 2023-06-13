import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../generated/l10n.dart';
import 'routes/build_routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      onGenerateRoute: buildRoutes(appRoutes),
      supportedLocales: S.delegate.supportedLocales,
      home: const Scaffold(body: Center(child: Text('Hello World'))),
    );
  }
}
