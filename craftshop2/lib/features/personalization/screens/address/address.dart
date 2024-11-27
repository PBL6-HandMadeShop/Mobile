import 'dart:convert';

import 'package:craftshop2/features/personalization/models/delivery_infor.dart';
import 'package:craftshop2/features/personalization/screens/address/widgets/single_address.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';

class UserAddressScreen extends StatefulWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  _UserAddressScreenState createState() => _UserAddressScreenState();
}

class _UserAddressScreenState extends State<UserAddressScreen> {
  final DeliveryController _deliveryController = DeliveryController();
  List<DeliveryInfo> _addresses = [];
  int? _selectedIndex; // Chỉ số của địa chỉ đang được chọn

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }


  Future<void> _loadAddresses() async {
    try {
      final addresses = await _deliveryController.getAddressList();
      final mainDelivery = await _deliveryController.getMainDelivery();
      if (!mounted) return;

      setState(() {
        _addresses = addresses;
        _isLoading = false;
        // Xác định chỉ số của địa chỉ giao hàng chính nếu có
        _selectedIndex = mainDelivery != null
            ? _addresses.indexWhere((address) =>
        address.address == mainDelivery.address &&
            address.city == mainDelivery.city)
            : null;
      });
    } catch (e) {
      print("Error loading addresses: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: CSColors.primaryColor,
        onPressed: () async {
          // Navigate đến màn hình thêm địa chỉ mới và refresh danh sách khi quay lại
          await Get.to(() => const AddNewAddressScreen());
          _loadAddresses();
        },
        child: const Icon(Iconsax.add, color: CSColors.white),
      ),
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text('Addresses', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Hiển thị loading
          : _addresses.isEmpty
          ? const Center(child: Text('No addresses found.')) // Hiển thị khi danh sách rỗng
          : ListView.builder(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        itemCount: _addresses.length,
        itemBuilder: (context, index) {
          final isSelected = index == _selectedIndex;

          return GestureDetector(
            onTap: () async {
              // Lưu địa chỉ được chọn làm chính
              setState(() {
                _selectedIndex = index;
              });
              await _deliveryController.setMainDelivery(_addresses[index]);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Set as main delivery address: ${_addresses[index].address}')),
              );
            },

            child: SizedBox(
              width: CSSize.spaceBtwItems,
              child: CSSingleAddress(
                selectedAddress: isSelected,
                info: _addresses[index],
              ),
            ),

          );

        },
      ),

    );
  }
}


