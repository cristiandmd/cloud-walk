@GenerateNiceMocks([MockSpec<NavigatorObserver>()])
import 'package:concerts_weather/app/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../utils/pump.dart';
import 'build_routes_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AppRoute>()])
void main() {
  testWidgets('when calling an existing route then handle it', (tester) async {
    final fooAppRoute = MockAppRoute();
    final navigatorObserver = MockNavigatorObserver();
    final route = MaterialPageRoute(builder: (_) => const SizedBox());
    when(fooAppRoute.type).thenReturn(AppRoutesNames.concerts);
    when(fooAppRoute.handle(any)).thenReturn(route);
    await tester.pumpSUT(routes: [fooAppRoute], observer: navigatorObserver);

    tester.navigateTo(AppRoutesNames.concerts.name);
    verify(navigatorObserver.didPush(route, any));
  });

  testWidgets('when calling an inexisting route then shows not found route', (tester) async {
    await tester.pumpSUT(routes: []);

    tester.navigateTo(AppRoutesNames.concerts.name);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('not-found-widget')), findsOneWidget);
  });
}
