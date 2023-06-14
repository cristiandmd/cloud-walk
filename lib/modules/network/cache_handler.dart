import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'connectivity_detector.dart';

final class CacheHandler {
  const CacheHandler({
    required ConnectivityDetector connectivityDetector,
    required Future<SharedPreferences> Function() sharedPreferences,
  })  : _connectivityDetector = connectivityDetector,
        _sharedPreferences = sharedPreferences;
  final ConnectivityDetector _connectivityDetector;
  final Future<SharedPreferences> Function() _sharedPreferences;

  Future<T> fetch<T>({
    required Future<T> Function() onFetch,
    required String storeKey,
  }) async {
    final isOnline = await _connectivityDetector.isOnline();
    T? data;
    if (isOnline) {
      data = await onFetch();
    }
    try {
      final preferences = await _sharedPreferences();
      if (data != null) {
        await preferences.setString(storeKey, json.encode(data));
      } else {
        data = preferences.getString(storeKey).map((value) => json.decode(value));
      }
    } catch (error) {
      if (data != null) {
        return data;
      }
      return Future.error(CacheMissError());
    }
    return data!;
  }
}

final class CacheMissError extends Error {}

extension Any<T> on T? {
  U? map<U>(U Function(T) mapper) {
    if (this != null) {
      return mapper(this as T);
    }
    return null;
  }
}
