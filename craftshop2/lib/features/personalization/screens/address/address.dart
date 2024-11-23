import 'package:craftshop2/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  _UserAddressScreenState createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  final API_Services apiServices = API_Services();
  Map<String, dynamic>? userInfo;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    try {
      String? token = await apiServices.storage.read(key: 'session_token');
      if (token == null) {
        print("User is not logged in");
        return;
      }

      Map<String, dynamic>? fetchedUserInfo = await apiServices.fetchDataUser(token);
      if (!mounted) return; // Check if widget is still in the tree

      setState(() {
        userInfo = fetchedUserInfo;
        isLoading = false;
      });
      print("User Info Loaded: $userInfo");
    } catch (e) {
      print("Error loading user info: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CSColors.primaryColor,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: CSColors.white),
      ), // FloatingActionButton
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ), // TAppBar
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            children: [
              CSSingleAddress(selectedAddress: true,infouser: userInfo,),
              CSSingleAddress(selectedAddress: false,infouser: userInfo),
              CSSingleAddress(selectedAddress: false,infouser: userInfo),
              CSSingleAddress(selectedAddress: false,infouser: userInfo),
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
