import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CSDeviceUtils {
  CSDeviceUtils._();
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color,
    ));
  }

  static bool isLandscapeOrienation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  static bool isPortraitOrienation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  static void setFullScreen( bool enable) {
    SystemChrome.setEnabledSystemUIMode(enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double getScreenHeight(){
    return MediaQuery.of(Get.context!).size.height;
  }
  static double getScreenWidth(Builder context){
    return MediaQuery.of(context as BuildContext).size.width;
  }
  static double getPixelRatio(){
    return MediaQuery.of(Get.context!).padding.top;
  }
  static double getStatusBarHeight(){
    return MediaQuery.of(Get.context!).padding.top;
  }
  static double getBottomNavigationBarHeight(){
    return kBottomNavigationBarHeight;
  }
  static double getAppBarHeight(){
    return kToolbarHeight;
  }
  static double getKeyBoardHeight(){
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom ;
  }
  static Future<bool> isKeyboardVisible() async {
    final viewInsets = MediaQuery.of(Get.context!).viewInsets;
    return viewInsets.bottom > 0;
  }
  static Future<bool> isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android || defaultTargetPlatform == TargetPlatform.iOS;
  }
  static void vibrate(Duration duration){
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }
  static Future<void> setPreferredOrientations(List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations((orientations));
  }
  static void hideStatusBar(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
  static void showStatusBar(){
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
  }

  static Future<bool> hasInternetConnection() async {
    try{
      final rs = await InternetAddress.lookup('google.com');
      return rs.isNotEmpty && rs[0].rawAddress.isNotEmpty;
    } on SocketException catch(_){
      return false;
    }
  }
  static bool isIOS(){
    return Platform.isIOS;
  }
  static bool isAndroid(){
    return Platform.isAndroid;
  }
  static void launchURL(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}