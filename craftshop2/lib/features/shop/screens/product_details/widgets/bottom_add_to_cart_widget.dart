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
    super.key,
    required this.productData,
  });

  final Map<String, dynamic> productData;

  @override
  _CSBottomAddToCartState createState() => _CSBottomAddToCartState();
}

class _CSBottomAddToCartState extends State<CSBottomAddToCart> {
  int _quantity = 1; // Khởi tạo số lượng là 1
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

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
  Future<void> _addToCart() async {
    String? token = await storage.read(key: 'session_token');
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You need to log in to add items to your cart.')),
      );
      return;
    }

    final productId = widget.productData["id"].toString();
    if (productId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid product ID')),
      );
      return;
    }

    try {
      // Gọi API thêm sản phẩm vào giỏ hàng
      final response = await api_services.addCartItem(productId, _quantity, token);

      if (response['status'] == 'ok') {
        // Hiển thị thông báo thành công
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added to cart successfully!')),
        );
      } else {
        // Hiển thị thông báo lỗi từ server

        print("Loi tai ScaffoldMessenger else");
        String errorMessage = response['message'] ?? 'An unknown error occurred.';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product: $errorMessage')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An error occurred while adding product to cart.')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CSSize.defaultSpace,
        vertical: CSSize.defaultSpace / 2,
      ),
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
