import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChangePhone extends StatelessWidget {
  const ChangePhone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Change Phone",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Change your phone number to receive notifications and updates",
              style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: CSSize.spaceBtwSections),
            Form(child: Column(children: [
              TextFormField(
                validator: (value) => CSValidator.validateEmptyText("Your Phone", value),
                expands: false,
                decoration: const InputDecoration(
                    labelText: "Your Phone",
                    prefixIcon: Icon(Iconsax.headphone)
                ),
              )
            ],)),
            const SizedBox(height: CSSize.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                // onPressed: () => api.update,
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}