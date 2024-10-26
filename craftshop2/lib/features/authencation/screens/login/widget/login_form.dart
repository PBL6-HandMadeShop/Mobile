import 'package:craftshop2/features/authencation/screens/password_configuration/forget_password.dart';
import 'package:craftshop2/features/authencation/screens/signUp/sign_up.dart';
import 'package:craftshop2/navigation_menu.dart';
import 'package:craftshop2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class CSLoginform extends StatelessWidget {
  const CSLoginform({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Form(child: Padding(
      padding: const EdgeInsets.symmetric(vertical: CSSize.spaceBtwSections),
      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.direct_right), labelText: CSText.email),
          ),
          const SizedBox(height: CSSize.spaceBtwInputFields,),
          TextFormField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check), labelText: CSText.password, suffixIcon: const Icon(Iconsax.eye_slash)),

          ),
          const SizedBox(height: CSSize.spaceBtwInputFields /2,),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // remember me
              Row(
                children: [
                  Checkbox(value: true, onChanged: (value){}),
                  const Text(CSText.rembemberMe),
                ],
              ),
              // forgot password
              TextButton(onPressed: ()=> Get.to(() =>ForgetPassword()), child: const Text(CSText.forgotPassword)),
            ],
          ),
          const SizedBox(height: CSSize.spaceBtwSections,),
          // sigin button
          SizedBox(
              width:double.infinity ,
              child: ElevatedButton(onPressed: () => Get.to(()=> const NavigationMenu()), child: const Text(CSText.signIn))),
          const SizedBox(height: CSSize.spaceBtwItems,),
          //.Sign up button
          SizedBox(
              width:double.infinity ,
              child: OutlinedButton(onPressed: () => Get.to(() => SignUpScreen()), child: const Text(CSText.createAccount))),
          const SizedBox(height: CSSize.spaceBtwSections,),
        ],
      ),
    )
    );
  }
}