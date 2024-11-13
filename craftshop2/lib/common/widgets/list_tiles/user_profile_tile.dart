import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/authencation/models/user_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../images/cs_circular_image.dart';

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
      final userDataJson = await CSLocalStorage.readData('user_data');
      if (userDataJson != null) {
        setState(() {
          _userData = User.fromJson(json.decode(userDataJson));
          isLoading = false;
        });
      } else {
        print('No user data found in local storage.');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Failed to load user info: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: isLoading
          ? const CircularProgressIndicator() // Show loading indicator while fetching
          : CSCircularImage(
        image: _userData?.avatar?.name ?? CSImage.user, // Fallback image if no avatar
        width: 50,
        height: 50,
        padding: 0,
      ),
      title: isLoading
          ? const Text('Loading...') // Show loading text while fetching
          : Text(
        _userData?.name ?? 'No Name', // Display user name or fallback text
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: CSColors.white),
      ),
      subtitle: isLoading
          ? const Text('') // Blank subtitle while loading
          : Text(
        _userData?.email ?? 'No Email', // Display user email or fallback text
        style: Theme.of(context).textTheme.headlineSmall!.apply(color: CSColors.white),
      ),
      trailing: IconButton(
        onPressed: widget.onPressed,
        icon: const Icon(Iconsax.edit, color: CSColors.white),
      ),
    );
  }
}
