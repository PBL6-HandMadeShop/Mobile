import 'package:craftshop2/features/authencation/screens/Loader/full_screen_loader.dart';
import 'package:craftshop2/utils/constants/image_string.dart';
import 'package:craftshop2/utils/loader/loaders.dart';
import 'package:craftshop2/utils/network/network_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  final name = TextEditingController();
  final email = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  ///-----------------Signup-----------------///
  Future<void> singup() async {
    try {
      CSFullScreenLoader.openLoadingDiaLog("We are processing your information......", CSImage.verify);
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {

        return;
      }
      if(!signupFormKey.currentState!.validate()){
        return;
      }
    } catch (e) {
      // Handle the error
      CSLoader.errorSnackBar(title: "Oh Snap", message: e.toString());
    } finally{
      CSFullScreenLoader.stopLoading();
    }

  }

}