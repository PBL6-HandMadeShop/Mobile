import 'package:craftshop2/features/authencation/screens/login/login.dart';
import 'package:craftshop2/utils/constants/image_string.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/constants/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/helper_functions.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed:()=> Get.offAll(()=> const LoginScreen()), icon: const Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child:  Padding(padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: Column(
          /// image
            children: [
              Image(image:  const AssetImage(CSImage.verify), width: CSHelperFunctions.screenWidth(),),
              /// Tilte and subtitle
              Text(CSText.confirmEmail, style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center,)
              ,const SizedBox(height: CSSize.spaceBtwSections,),
              Text(CSText.confirmEmailSubtitle, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center,),
              /// button
              const SizedBox(height: CSSize.spaceBtwSections,),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: ()=> Get.to(() => const LoginScreen()), child: const Text(CSText.backtoLogin)),),
              const SizedBox(height: CSSize.spaceBtwSections,),
            ],

        ),),
      ),
    );

  }
}
