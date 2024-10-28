import 'package:craftshop2/features/authencation/screens/signUp/verify_email.dart';
import 'package:craftshop2/features/authencation/screens/signUp/widgets/term_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class CSSignupForm extends StatelessWidget {
  const CSSignupForm({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CSText.FirstName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
              const SizedBox(
                width: CSSize.spaceBtwInputFields,
              ),
              Flexible(
                child: TextFormField(
                  expands: false,
                  decoration: const InputDecoration(
                    labelText: CSText.LastName,
                    prefixIcon: Icon(Iconsax.user),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: CSSize.spaceBtwInputFields,
          ),

          /// Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: CSText.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(
            height: CSSize.spaceBtwInputFields,
          ),

          /// Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: CSText.address,
              prefixIcon: Icon(Iconsax.home),
            ),
          ),
          const SizedBox(
            height: CSSize.spaceBtwInputFields,
          ),

          /// Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: CSText.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
          ),
          const SizedBox(
            height: CSSize.spaceBtwInputFields,
          ),

          /// Username
          TextFormField(
            expands: false,
            decoration: const InputDecoration(
              labelText: CSText.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(
            height: CSSize.spaceBtwInputFields,
          ),

          /// term and condition
          CSTermAndConditionCheckBox(dark: dark),

          /// sign up button
          const SizedBox(
            height: CSSize.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                onPressed: () => Get.to(()=> const VerifyEmailScreen()),
                child: const Text(CSText.createAccount)),
          )
        ],
      ),
    );
  }
}

