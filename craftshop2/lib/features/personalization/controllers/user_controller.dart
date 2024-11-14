import 'package:get/get.dart';

import '../../../utils/local_storage/storage_utility.dart';
import '../../authencation/models/user_model.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  Future<User?> displayUserInfo() async {
    try {
      final user = await CSLocalStorage.loadUserData();
      if (user != null) {
        return user;
      } else {
        print("No user data found");
      }
    } catch (e) {
      print("Error fetching user info: $e");
    }
    return null;
  }
}