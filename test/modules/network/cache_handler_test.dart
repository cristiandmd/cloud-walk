import 'package:concerts_weather/modules/network/cache_handler.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateNiceMocks([MockSpec<ConnectivityDetector>()])
import 'package:concerts_weather/modules/network/connectivity_detector.dart';
import 'package:mockito/mockito.dart';
@GenerateNiceMocks([MockSpec<SharedPreferences>()])
import 'package:shared_preferences/shared_preferences.dart';
import 'cache_handler_test.mocks.dart';

void main() {
  group('#fetch', () {
    test('when connectivity detector throws an error and fetch fails then returns fetch error', () {
      final connectivityDetector = MockConnectivityDetector();
      final sharedPreferences = MockSharedPreferences();
      when(connectivityDetector.isOnline()).thenAnswer((_) => Future.error(Exception()));
      final sut = makeSUT(connectivityDetector, () async => sharedPreferences);

      expect(sut.fetch(onFetch: () async => true, storeKey: 'foo'), throwsException);
    });

    test('when is online and fetch fails then returns fetch error', () {
      final connectivityDetector = MockConnectivityDetector();
      when(connectivityDetector.isOnline()).thenAnswer((_) => Future.value(true));
      final sharedPreferences = MockSharedPreferences();
      final sut = makeSUT(connectivityDetector, () async => sharedPreferences);

      expect(sut.fetch(onFetch: () => Future.error(Exception()), storeKey: 'foo'), throwsException);
    });

    test('when is not online and fails to start the storage then throws CacheMissError', () {
      final connectivityDetector = MockConnectivityDetector();
      when(connectivityDetector.isOnline()).thenAnswer((_) => Future.value(false));
      final sut = makeSUT(connectivityDetector, () => Future.error(Exception()));

      expect(
        sut.fetch(onFetch: () async => true, storeKey: 'foo'),
        throwsA(isA<CacheMissError>()),
      );
    });

    test('when is not online and fails to get stored value then throws CacheMissError', () {
      final connectivityDetector = MockConnectivityDetector();
      final sharedPreferences = MockSharedPreferences();
      when(connectivityDetector.isOnline()).thenAnswer((_) => Future.value(false));
      when(sharedPreferences.getString('foo')).thenThrow(Exception());
      final sut = makeSUT(connectivityDetector, () async => sharedPreferences);

      expect(
        sut.fetch(onFetch: () async => true, storeKey: 'foo'),
        throwsA(isA<CacheMissError>()),
      );
    });

    test('when is online and fails to store the value then returns the fetched data', () {
      final connectivityDetector = MockConnectivityDetector();
      final sharedPreferences = MockSharedPreferences();
      when(connectivityDetector.isOnline()).thenAnswer((_) => Future.value(true));
      when(sharedPreferences.getString('foo')).thenThrow(Exception());
      final sut = makeSUT(connectivityDetector, () async => sharedPreferences);

      expect(
        sut.fetch(onFetch: () async => true, storeKey: 'foo'),
        completion(true),
      );
    });

    test('when is online and succeed to store the value then returns the fetched data', () {
      final connectivityDetector = MockConnectivityDetector();
      final sharedPreferences = MockSharedPreferences();
      when(connectivityDetector.isOnline()).thenAnswer((_) => Future.value(true));
      when(sharedPreferences.getString('foo')).thenThrow(Exception());
      final sut = makeSUT(connectivityDetector, () async => sharedPreferences);

      expect(
        sut.fetch(onFetch: () async => true, storeKey: 'foo'),
        completion(true),
      );
    });
  });
}

CacheHandler makeSUT(
  ConnectivityDetector connectivityDetector,
  Future<SharedPreferences> Function() sharedPreferences,
) {
  return BaseCacheHandler(
    connectivityDetector: connectivityDetector,
    sharedPreferences: () async => sharedPreferences(),
  );
}
