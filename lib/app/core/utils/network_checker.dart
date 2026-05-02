import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class ConnectionChecker {
  /// Check current internet connection
  static Future<bool> checkConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      // In v7+, this is a List<ConnectivityResult>
      return connectivityResult.isNotEmpty && connectivityResult.first != ConnectivityResult.none;
    } on PlatformException catch (e) {
      debugPrint("Error checking connection: $e");
      return false;
    }
  }

  /// Stream to listen for connectivity changes (v7+)
  static Stream<List<ConnectivityResult>> get connectivityStream => Connectivity().onConnectivityChanged;
}
