import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkConnectionService extends GetxService {

  late Connectivity connectivity;

  @override
  void onInit() {
    connectivity  = Connectivity();
    super.onInit();
  }



   Future<bool> isOnline() async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
}