import 'package:craftshop2/utils/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/authencation/models/user_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_string.dart';
import '../images/cs_circular_image.dart';
import 'dart:typed_data';

class CSUserProfileTile extends StatefulWidget {
  const CSUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  _CSUserProfileTile createState() => _CSUserProfileTile();
}

class _CSUserProfileTile extends State<CSUserProfileTile> {
  User? _userData;
  bool isLoading = true;
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();
  Map<String, dynamic>? userInfo;
  Uint8List? fileData;

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
      Map<String, dynamic>? fetchedData = await api_services.fetchDataUser(token!);

      setState(() {
        userInfo = fetchedData;
        isLoading = false;
      });
      print(userInfo);
      print("id:  ${userInfo?['avatar']?['id']}");
      fileData = await api_services.downloadFile("${userInfo?['avatar']?['id']}", token);
    } catch (e) {
      print('Failed to load user info: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CSCircularImage(
        image: fileData?? CSImage.user,
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: Text(
        userInfo?['name'] ?? 'No Name',
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: CSColors.white),
      ),
      subtitle: Text(
        userInfo?['email'] ?? 'No Email',
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: CSColors.white),
      ),
      trailing: IconButton(
        onPressed: widget.onPressed,
        icon: const Icon(Iconsax.edit, color: CSColors.white),
      ),
    );
  }
}