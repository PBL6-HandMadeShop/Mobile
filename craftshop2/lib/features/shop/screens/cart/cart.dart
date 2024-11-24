import 'dart:convert'; // Thư viện để mã hóa và giải mã JSON
import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/common/widgets/products/cart/cart_item.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../../../../utils/http/api_service.dart';
import '../checkout/checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final API_Services _apiServices = API_Services();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  bool isLoading = true;
  List<dynamic> cartItems = [];
  double totalAmount = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchCartItems(); // Gọi API để lấy giỏ hàng
  }

  Future<void> _fetchCartItems() async {
    setState(() {
      isLoading = true; // Hiển thị trạng thái tải
    });

    try {
      // Đọc token người dùng từ FlutterSecureStorage
      String? token = await _storage.read(key: 'session_token');
      if (token == null) {
        throw Exception("Bạn chưa đăng nhập. Vui lòng đăng nhập để tiếp tục.");
      }

      // Gọi API để lấy dữ liệu giỏ hàng
      final response = await _apiServices.fetchCartItems(token);

      if (response['status'] == 'ok') {
        setState(() {
          cartItems = response['content'] ?? []; // Cập nhật giỏ hàng
          totalAmount = cartItems.fold(
            0.0,
                (sum, item) {
              final currentPrice = double.tryParse(item['product']['currentPrice'].toString()) ?? 0.0;
              final quantity = int.tryParse(item['quantity'].toString()) ?? 0;
              return sum + (currentPrice * quantity);
            },
          );

        });

        // Lưu giỏ hàng mới nhất vào storage
        await _storage.write(key: 'cart_items', value: jsonEncode(cartItems));
      } else {
        throw Exception(response['message'] ?? "Không thể tải giỏ hàng.");
      }
    } catch (e) {
      // Hiển thị lỗi nếu không lấy được dữ liệu
      Get.snackbar(
        "Lỗi",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false; // Tắt trạng thái tải
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text('Giỏ Hàng', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : cartItems.isEmpty
          ? const Center(child: Text("Giỏ hàng của bạn đang trống"))
          : ListView.builder(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final item = cartItems[index];
          return CSCartItem(
            productName: item['product']['name'],
            productImage: item['product']['avatarBlob']['name'],
            productPrice: item['product']['currentPrice'],
            productQuantity: item['quantity'],
          );
        },
      ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Padding(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            // Điều hướng sang màn hình thanh toán
            Get.to(() => const CheckoutScreen());
          },
          child: Text('Thanh Toán (${totalAmount.toStringAsFixed(0)}₫)'),
        ),
      )
          : null,
    );
  }
}
