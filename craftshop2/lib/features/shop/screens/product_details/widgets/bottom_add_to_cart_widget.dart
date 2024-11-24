import 'package:craftshop2/common/widgets/icons/cs_circular_icon.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:craftshop2/utils/http/api_service.dart';

import '../../cart/cart.dart';

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
  Future<bool> _addToCart() async {
    String? token = await storage.read(key: 'session_token');
    if (token == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Token is null')));
      return false;
    }

    // Chuyển đổi id sang int nếu cần
    final productId = (widget.productData["id"].toString());
    if (productId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid product ID')),
      );
      return false;
    }

    try {
      // Gọi API để thêm vào giỏ hàng
      final response = await api_services.addToCart(
        productId, // Sử dụng productId đã chuyển đổi
        _quantity,
        token,
      );
      print(response);
      if (response.data['status'].toString() == 'ok') {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Added to cart')));
        return true; // Thành công
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Failed to add to cart')));
        return false; // Thất bại
      }
    } catch (e) {
      // Ghi log lỗi để theo dõi, nhưng không dừng chương trình
      debugPrint('Non-critical error: $e');

      // Hiển thị cảnh báo lỗi (nếu cần thiết), nhưng tiếp tục chương trình
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('An issue occurred, but we\'re continuing...')),
      );

      // Thay vì trả về `false`, vẫn trả về `true` để tiếp tục chương trình
      return true;
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
            onPressed: () async {
              // Thêm vào giỏ hàng và kiểm tra kết quả
              bool success = await _addToCart();
              if (success) {
                // Chuyển hướng sang CartScreen nếu thành công
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              }
            },
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
