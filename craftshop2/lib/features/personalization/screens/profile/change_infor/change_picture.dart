import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/http/api_service.dart';

class ChangePicture extends StatefulWidget {
  const ChangePicture({Key? key}) : super(key: key);

  @override
  _UpdateAvatarPageState createState() => _UpdateAvatarPageState();
}

class _UpdateAvatarPageState extends State<ChangePicture> {
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  final TextEditingController nameChange = TextEditingController();
  Map<String, dynamic>? userInfo;
  File? _avatarFile;
  void initState() {
    super.initState();
  }

  /// Hàm chọn ảnh từ thư viện
  Future<void> _pickAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _avatarFile = File(image.path);
      });
    }
  }

  Future<void> _updateInformation() async {
    try {
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic>? fetchedData = await api_services.fetchDataUser(token!);
      setState(() {
        userInfo = fetchedData;
      });
      if (token != null) {
        await api_services.updateInformation(token: token, avatar: _avatarFile);
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
      appBar: AppBar(
        title: const Text('Update Avatar'),
        centerTitle: true,
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _pickAvatar,
                child: _avatarFile != null
                    ? CircleAvatar(
                  radius: 80,
                  backgroundImage: FileImage(_avatarFile!),
                )
                    : const CircleAvatar(
                  radius: 80,
                  child: Icon(
                    Iconsax.camera,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Thực hiện hành động lưu avatar (upload file lên server)
                  if (_avatarFile != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Avatar updated successfully!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select an avatar!')),
                    );
                  }
                },
                child: SizedBox(
                  child: TextButton(
                    onPressed: _updateInformation,
                    child: const Text('Change Profile Picture', style: TextStyle(color: Colors.white)),
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
