import 'dart:typed_data';  // To work with Uint8List
import 'package:craftshop2/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/cs_circular_image.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';
import '../../../authencation/screens/login/login.dart';


import 'change_infor/change_name.dart';
import 'change_infor/change_phone.dart';
import 'change_infor/change_picture.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isLoading = true;
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Map<String, dynamic>? userInfo;
  Uint8List? fileData;


  @override
  void initState() {
    super.initState();
    _loadUserInfoAndAvatar();
  }

  Future<void> _loadUserInfoAndAvatar() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await storage.read(key: 'session_token');
      if (token == null) throw Exception("Token is null");

      // Tải song song thông tin user và file avatar
      final userInfoFuture = api_services.fetchDataUser(token);
      final avatarFuture = userInfoFuture.then((data) async {
        if (data?['avatar']?['id'] != null) {
          return api_services.downloadFile("${data?['avatar']?['id']}", token);
        }
        return null; // Không có avatar
      });

      // Chờ cả hai Future hoàn thành
      final results = await Future.wait([userInfoFuture, avatarFuture]);
      setState(() {
        userInfo = results[0] as Map<String, dynamic>?;
        fileData = results[1] as Uint8List?;
      });
    } catch (e) {
      print('Failed to load user info or avatar: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || userInfo == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: const CSAppBar(showBackArrow: true, title: Text('Profile')),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              /// Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    CSCircularImage(
                        image: fileData ?? CSImage.user, width: 80, height: 80),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const ChangePicture());
                      },
                      child: const Text('Change Profile Picture'),
                    ),
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
                onPressed: () => Get.to(() => const ChangeName()),
                title: "Name",
                value: userInfo != null && userInfo!.containsKey('name') ? "${userInfo!['name']}" : 'No loading',
              ),
              CSProfileMenu(
                  onPressed: () {}, title: 'Username',
                  value: "${userInfo!["username"]}" ?? 'No loading'),

              const SizedBox(height: CSSize.spaceBtwItems),
              const Divider(),
              const SizedBox(height: CSSize.spaceBtwItems),

              const CSSectionHeading(
                  title: 'Personal Information', showActionButton: false),
              const SizedBox(height: CSSize.spaceBtwItems),

              CSProfileMenu(
                  onPressed: () async {
                    String userId = "${userInfo!['id']}" ?? 'No loading';

                    // Copy to clipboard
                    await Clipboard.setData(ClipboardData(text: userId));

                    // Show confirmation to user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User ID copied to clipboard')),
                    );
                  },
                  title: 'User ID',
                  icon: Iconsax.copy,
                  value: "${userInfo!['id']}" ?? 'No loading'),
              CSProfileMenu(
                  onPressed: () async {
                    String email = "${userInfo!['email']}" ?? 'No loading';

                    // Copy to clipboard
                    await Clipboard.setData(ClipboardData(text: email));

                    // Show confirmation to user
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Email copied to clipboard')),
                    );
                  },
                  icon: Iconsax.copy,
                  title: 'E-mail',
                  value: "${userInfo!['email']}" ?? 'No loading'),
              CSProfileMenu(
                  onPressed: () => Get.to(() => const ChangePhone()),
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
