import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
@GenerateNiceMocks([MockSpec<Connectivity>()])
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:concerts_weather/modules/network/connectivity_detector.dart';
import 'package:mockito/mockito.dart';
import 'connectivity_detector_test.mocks.dart';

void main() {
  group('#isOnline', () {
    test('when is wifi then returns true', () {
      final connectivity = MockConnectivity();
      when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);
      final sut = makeSUT(connectivity);

      expect(sut.isOnline(), completion(true));
    });

    test('when is mobile then returns true', () {
      final connectivity = MockConnectivity();
      when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.mobile);
      final sut = makeSUT(connectivity);

      expect(sut.isOnline(), completion(true));
    });

    test('when is bluetooth then returns false', () {
      final connectivity = MockConnectivity();
      when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.bluetooth);
      final sut = makeSUT(connectivity);

      expect(sut.isOnline(), completion(false));
    });

    test('when is ethernet then returns false', () {
      final connectivity = MockConnectivity();
      when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.ethernet);
      final sut = makeSUT(connectivity);

      expect(sut.isOnline(), completion(false));
    });

    test('when is vpn then returns false', () {
      final connectivity = MockConnectivity();
      when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.vpn);
      final sut = makeSUT(connectivity);

      expect(sut.isOnline(), completion(false));
    });

    test('when is other then returns false', () {
      final connectivity = MockConnectivity();
      when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.other);
      final sut = makeSUT(connectivity);

      expect(sut.isOnline(), completion(false));
    });

    test('when is none then returns false', () {
      final connectivity = MockConnectivity();
      when(connectivity.checkConnectivity()).thenAnswer((_) async => ConnectivityResult.none);
      final sut = makeSUT(connectivity);

      expect(sut.isOnline(), completion(false));
    });
    test('when throws any exception then returns false', () {
      final connectivity = MockConnectivity();
      when(connectivity.checkConnectivity()).thenAnswer((_) => Future.error(Error()));
      final sut = makeSUT(connectivity);

      expect(sut.isOnline(), completion(false));
    });
  });
}

ConnectivityDetector makeSUT(Connectivity connectivity) {
  return BaseConnectivityDetector(connectivity);
}
