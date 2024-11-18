import 'package:craftshop2/common/widgets/icons/cs_circular_icon.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:craftshop2/utils/http/api_service.dart';

class CSBottomAddToCart extends StatefulWidget {
  const CSBottomAddToCart({
    super.key, required this.productData,
  });
  final Map<String, dynamic> productData;
  @override
  _CSBottomAddToCartState createState() => _CSBottomAddToCartState();
}

class _CSBottomAddToCartState extends State<CSBottomAddToCart> {
  int _quantity = 1; // Khởi tạo số lượng là 1
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  // Hàm tăng số lượng
  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
  }

  // Hàm giảm số lượng
  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  // Hàm thêm vào giỏ hàng
  void _addToCart() async {
    String? token = await storage.read(key: 'session_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Token is null')));
      return;
    }

    try {
      // Gọi API để thêm vào giỏ hàng
      final response = await api_services.addToCart(widget.productData["id"], _quantity, token);


      if (response.data['status'] == 'ok') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to cart')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add to cart')));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: CSSize.defaultSpace, vertical: CSSize.defaultSpace / 2),
      decoration: BoxDecoration(
        color: dark ? CSColors.darkerGrey : CSColors.light,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(CSSize.cardRadiusLg),
          topRight: Radius.circular(CSSize.cardRadiusLg),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Nút giảm số lượng
              GestureDetector(
                onTap: _decreaseQuantity,
                child: const CSCircularlIcon(
                  icon: Iconsax.minus,
                  backgroundColor: CSColors.darkerGrey,
                  width: 40,
                  height: 40,
                  color: CSColors.white,
                ),
              ),
              const SizedBox(width: CSSize.spaceBtwItems),
              // Hiển thị số lượng
              Text(
                '$_quantity',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(width: CSSize.spaceBtwItems),
              // Nút tăng số lượng
              GestureDetector(
                onTap: _increaseQuantity,
                child: const CSCircularlIcon(
                  icon: Iconsax.add,
                  backgroundColor: CSColors.black,
                  width: 40,
                  height: 40,
                  color: CSColors.white,
                ),
              ),
            ],
          ),
          // Nút thêm vào giỏ hàng
          ElevatedButton(
            onPressed: _addToCart,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(CSSize.md),
              backgroundColor: CSColors.black,
              side: const BorderSide(color: CSColors.black),
            ),
            child: const Text('Add to Cart'),
          ),
        ],
      ),
    );
  }
}
