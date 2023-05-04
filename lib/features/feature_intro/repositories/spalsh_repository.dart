import 'package:connectivity_plus/connectivity_plus.dart';

class SplashRepository {
  /// this function checks user internet connectivity!
  /// if user was connected to `WIFI` or `INTERNET`
  ///  we return `true`else we return `flase`
  Future<bool> checkConnectivity() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.mobile) {
      return true;
    } else if (result == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}
