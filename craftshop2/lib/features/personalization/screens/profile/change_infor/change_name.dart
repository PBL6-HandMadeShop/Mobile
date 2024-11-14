import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/http/api_service.dart';
import '../profile.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Change Name",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Use real name for easy verification. This name will apper on server page",
            style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: CSSize.spaceBtwSections),
            Form(child: Column(children: [
              TextFormField(
                validator: (value) => CSValidator.validateEmptyText("Your Name", value),
                expands: false,
                decoration: const InputDecoration(
                  labelText: "Your Name",
                  prefixIcon: Icon(Iconsax.user)
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

  @override
  _ChangeName createState() => _ChangeName();
}

class _ChangeName extends State<ChangeName> {
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final TextEditingController nameChange = TextEditingController();
  Map<String, dynamic>? userInfo;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _updateInformation() async {
    try {
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic>? fetchedData = await api_services.fetchDataUser(token!);
      setState(() {
        userInfo = fetchedData;
      });
      if (token != null && nameChange.text.trim().isNotEmpty) {
        await api_services.updateInformation(token: token, name: nameChange.text.trim());
        print('User info updated successfully');
      } else {
        print('User is not logged in or name is empty');
      }
    } catch (e) {
      print('Failed to update user info: $e');
    }
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          'Change Name',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Use real name for easy verification. This name will appear on server page",
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: CSSize.spaceBtwSections),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    controller: nameChange,
                    decoration: const InputDecoration(
                      labelText: "Your Name",
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CSSize.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updateInformation,
                child: const Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

}