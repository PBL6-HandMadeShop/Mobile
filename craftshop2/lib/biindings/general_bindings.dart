import 'package:craftshop2/utils/network/network_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
  }
}