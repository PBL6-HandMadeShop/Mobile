import 'package:craftshop2/common/widgets/loaders/animation_loader.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart%20';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CSFullScreenLoader{
  static void openLoadingDiaLog(String text, String animation){
    showDialog(context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => PopScope(
            canPop: false,
            child: Container(
              color: CSHelperFunctions.isDarkMode(Get.context!) ? CSColors.dark : CSColors.white,
              width: double.infinity,
              height: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 250),
                  CSAnimationLoaderWidget(text: text, animation: animation,),
                ],
              ),
            )
        )
    );
  }
  static stopLoading(){
    Navigator.of(Get.overlayContext!).pop();
  }
}