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
import 'dart:typed_data';

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
  List<Uint8List?> fileDataList = []; // Danh sách lưu dữ liệu tệp
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
      String? token = await _storage.read(key: 'session_token');

      if (token == null) {
        throw Exception("Bạn chưa đăng nhập. Vui lòng đăng nhập để tiếp tục.");
      }

      final response = await _apiServices.fetchCartItems(token);

      if (response['status'] == 'ok') {
        setState(() {
          cartItems = response['content'] ?? [];
          fileDataList = List<Uint8List?>.filled(cartItems.length, null);

          totalAmount = cartItems.fold(
            0.0,
                (sum, item) {
              final currentPrice = double.tryParse(item['product']['currentPrice'].toString()) ?? 0.0;
              final quantity = item['quantity'] is int
                  ? item['quantity']
                  : int.tryParse(item['quantity'].toString()) ?? 0;
              return sum + (currentPrice * quantity);
            },
          );
        });

        // Tải từng tệp dựa trên `avatarBlob.id`
        for (int i = 0; i < cartItems.length; i++) {
          final avatarId = cartItems[i]['product']['avatarBlob']['id'];
          _fetchFileData(i, avatarId, token);
        }

        await _storage.write(key: 'cart_items', value: jsonEncode(cartItems));
      } else {
        throw Exception(response['message'] ?? "Không thể tải giỏ hàng.");
      }
    } catch (e) {
      Get.snackbar(
        "Lỗi",
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchFileData(int index, String avatarId, String token) async {
    try {
      final data = await _apiServices.downloadFile(avatarId, token);
      setState(() {
        fileDataList[index] = data;
      });
    } catch (e) {
      print("Failed to fetch file for index $index: $e");
      fileDataList[index] = null;
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
          final item = cartItems![index];
          final fileData = fileDataList![index];

          return CSCartItem(
            productName: item['product']['name'],
            productImage: fileData,
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
            Get.to(() => const CheckoutScreen());
          },
          child: Text('Thanh Toán (${totalAmount.toStringAsFixed(0)}₫)'),
        ),
      )
          : null,
    );
  }
}

