import 'dart:convert';

import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:craftshop2/features/authencation/controllers/connect_api/api_service.dart';
import 'package:craftshop2/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/cs_circular_image.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/http_client.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../authencation/models/user_model.dart';
import '../../../authencation/screens/login/login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _userData;
  bool isLoading = true;
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Map<String, dynamic>? userInfo;
  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic>? fetchedData = await api_services.fetchData(token!);
      setState(() {
        userInfo = fetchedData;
        isLoading = false;
      });
      print(userInfo);
    } catch (e) {
      print('Failed to load user info: $e');
    }  finally {
      setState(() {
        isLoading = false;
      });
    }
    if (userInfo != null) {
      // Access userInfo fields
      String? name = "${userInfo!['name']}"; // Make sure this field is not null
    } else {
      // Handle the case where userInfo is null
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CSAppBar(showBackArrow: true, title: Text('Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CSCircularImage(
                        image: CSImage.user, width: 80, height: 80),
                    TextButton(
                        onPressed: () {},
                        child: const Text('Change Profile Picture')),
                  ],
                ),
              ),

              /// details
              const SizedBox(height: CSSize.spaceBtwItems / 2),

              const SizedBox(height: CSSize.spaceBtwItems),

              ///Heading Profile Info
              const CSSectionHeading(
                  title: 'Profile Information', showActionButton: false),
              const SizedBox(height: CSSize.spaceBtwItems),

              CSProfileMenu(
                  onPressed: () {},
                  title: "Name",
                  value: "${userInfo!['name']}" ?? 'No loading'),
              CSProfileMenu(
                  onPressed: () {}, title: 'Username',
                  value:"${userInfo!["username"]}" ?? 'No loading'),

              const SizedBox(height: CSSize.spaceBtwItems),
              const Divider(),
              const SizedBox(height: CSSize.spaceBtwItems),

              const CSSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: CSSize.spaceBtwItems),

              CSProfileMenu(
                  onPressed: () {},
                  title: 'User ID',
                  icon: Iconsax.copy,
                  value: "${userInfo!['id']}" ?? 'No loading'),
              CSProfileMenu(
                  onPressed: () {}, title: 'E-mail', value: "${userInfo!['email']}" ?? 'No loading'),
              CSProfileMenu(
                  onPressed: () {},
                  title: 'Phone Number',
                  value: "${userInfo!['phoneNumber']}" ?? 'No loading'),
              CSProfileMenu(onPressed: () {}, title: 'Gender', value: "${userInfo!['gender']}" ?? 'N/A'),
              CSProfileMenu(
                  onPressed: () {}, title: 'Birthday', value: "${userInfo!['birthDate']}".toString() ?? 'N/A'),
              const Divider(),
              const SizedBox(height: CSSize.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () async{
                    if ("${userInfo!['accountStatus']}" != 'ACTIVE') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Account is not active. Logout denied.')),
                      );
                      return;
                    }
                    final response = await api_services.logout();
                    Get.to(() => const LoginScreen());
                  },
                  child: const Text('Close Account'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red, // Set the text color to red
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
