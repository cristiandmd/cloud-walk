import 'package:connectivity_plus/connectivity_plus.dart';

abstract class ConnectivityDetector {
  Future<bool> isOnline();
}

final class BaseConnectivityDetector implements ConnectivityDetector {
  BaseConnectivityDetector(this._connectivity);
  final Connectivity _connectivity;

  @override
  Future<bool> isOnline() async {
    try {
      return await _connectivity
          .checkConnectivity()
          .then([ConnectivityResult.wifi, ConnectivityResult.mobile].contains)
          .catchError((_, __) async => false);
    } catch (_) {
      return false;
    }
  }
}
