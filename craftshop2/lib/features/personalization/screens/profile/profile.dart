import 'dart:convert';

import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:craftshop2/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/cs_circular_image.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/http_client.dart';
import '../../../../utils/local_storage/storage_utility.dart';
import '../../../authencation/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? _userData;
  bool isLoading = true;

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
      // final response = await CSHttpClient.getUserInfo();
      //
      // if (response['status'] == 'ok') {
      //   // Parse and set user data
      //   setState(() {
      //     _userData = User.fromJson(response['content']);
      //     isLoading = false;
      //     print("User info fetched: $_userData");
      //   });
      // Attempt to read user data from local storage
      final userDataJson = await CSLocalStorage.readData(
          'user_data'); // Assuming you saved user data as JSON
      if (userDataJson != null) {
        // Parse the user data
        setState(() {
          _userData = User.fromJson(json.decode(userDataJson));
          isLoading = false;
        });
      } else {
        print('No user data found in local storage.');
      }
    } catch (e) {
      print('Failed to load user info: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
    if (_userData != null) {
      // Access userInfo fields
      String? name = _userData!.name; // Make sure this field is not null
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
                  value: _userData?.name ?? 'No loading'),
              CSProfileMenu(
                  onPressed: () {}, title: 'Username',
                  value:_userData?.username ?? 'No loading'),

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
                  value: _userData?.id ?? 'No loading'),
              CSProfileMenu(
                  onPressed: () {}, title: 'E-mail', value: _userData?.email ?? 'No loading'),
              CSProfileMenu(
                  onPressed: () {},
                  title: 'Phone Number',
                  value: _userData?.phoneNumber ?? 'No loading'),
              CSProfileMenu(onPressed: () {}, title: 'Gender', value: _userData?.gender ?? 'N/A'),
              CSProfileMenu(
                  onPressed: () {}, title: 'Birthday', value: _userData?.birthDate?.toString() ?? 'N/A'),
              const Divider(),
              const SizedBox(height: CSSize.spaceBtwItems),

              Center(
                child: TextButton(
                  onPressed: () {},
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
