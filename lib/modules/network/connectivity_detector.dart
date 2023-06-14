import 'package:connectivity_plus/connectivity_plus.dart';

final class ConnectivityDetector {
  ConnectivityDetector(this._connectivity);
  final Connectivity _connectivity;

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
