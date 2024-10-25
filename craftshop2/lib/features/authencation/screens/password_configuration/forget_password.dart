import 'package:craftshop2/features/authencation/screens/password_configuration/reset_password.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body:  Padding(padding: EdgeInsets.all(CSSize.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Headings
          Text(CSText.forgotPasswordTitle,style: Theme.of(context).textTheme.headlineMedium,),
          const SizedBox(height: CSSize.spaceBtwItems,),
          Text(CSText.forgotPasswordSubtitle,style: Theme.of(context).textTheme.labelMedium,),
          const SizedBox(height: CSSize.spaceBtwSections*2,),

          // Textfiled
          TextFormField(
            decoration: const InputDecoration(labelText: CSText.email, prefixIcon: Icon(Iconsax.direct_right)),
          ),
          const SizedBox(height: CSSize.spaceBtwSections,),
          // Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: ()=> Get.off(() => ResetPassword()), child: const Text(CSText.confirmEmail)),
          )
        ],
      ),),
    );
  }
}
