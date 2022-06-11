import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectivityProvider extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  // instance of ConnectivityResult which holds the current internet access
  ConnectivityResult? _connectivityResult;

  // Creating instance of streamSubscription to listen when [_connectivity.onConnectivityChanged]
  // emits new value
  StreamSubscription<ConnectivityResult>? _streamSubscription;

  /// getter of [_connectivityResult]
  ConnectivityResult? get connectivityResult => _connectivityResult;

  Future<void> init() async {
    // by default set result to none
    _connectivityResult = ConnectivityResult.none;

    // if connection gets changed then listen for it
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectivityResult);

    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      _connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (_) {
      // print(e.toString());
    }
  }

  /// update [_connectivityResult] to given result
  void _updateConnectivityResult(ConnectivityResult result) {
    _connectivityResult = result;
    notifyListeners();
  }

  // cancel stream subscription
  void clear() async {
    await _streamSubscription?.cancel();
  }
}
