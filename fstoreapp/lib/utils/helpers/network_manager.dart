import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fstoreapp/utils/popups/snackbars.dart';
import 'package:get/get.dart';

/// Manages the network connectivity status and provides methods to check and handle connectivity changes.
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;
  final RxList<ConnectivityResult> _connectionStatus =
      <ConnectivityResult>[].obs;

  /// Initialize the network manager and set up a stream to continually check the connection status.
  @override
  void onInit() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  /// Update the connection status based on changes in connectivity and show a relevant popup for no internet connection.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;
    if (result.contains(ConnectivityResult.none)) {
      Snackbars.customToast(message: 'No Internet Connection');
    }
  }

  /// Check the internet connection status.
  /// Returns `true` if connected `false` otherwise.
  Future<bool> isConnected() async {
    final result = await _connectivity.checkConnectivity();
    if (result.any((element) => element == ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }

  /// Dispose or close the active connectivity stream
  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
