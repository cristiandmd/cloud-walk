import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:concerts_weather/modules/shared/mappers.dart';
import 'connectivity_detector.dart';

abstract class CacheHandler {
  Future<T> fetch<T>({
    required Future<T> Function() onFetch,
    required T Function(Map<String, dynamic>) map,
    required String storeKey,
  });
}

class SharedPreferencesCacheHandler implements CacheHandler {
  const SharedPreferencesCacheHandler({
    required ConnectivityDetector connectivityDetector,
    required Future<SharedPreferences> Function() sharedPreferences,
  })  : _connectivityDetector = connectivityDetector,
        _sharedPreferences = sharedPreferences;
  final ConnectivityDetector _connectivityDetector;
  final Future<SharedPreferences> Function() _sharedPreferences;

  @override
  Future<T> fetch<T>({
    required Future<T> Function() onFetch,
    required T Function(Map<String, dynamic>) map,
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
        await preferences.setString(storeKey, jsonEncode(data));
      } else {
        data = map(preferences.getString(storeKey).map(jsonDecode));
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
