import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/constants/texts.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/http/api_service.dart';
import '../../styles/spacing_styles.dart'; // Giả sử đây là nơi chứa API submitOrder

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.onPressed,
    required this.orderId, // Thêm orderId
    required this.token,   // Thêm token
  });

  final String image, title, subTitle;
  final VoidCallback onPressed;
  final String orderId;  // Nhận orderId
  final String token;    // Nhận token

  Future<void> _submitOrder() async {
    try {
      // Gọi API submitOrder
      final response = await API_Services().submitOrder(
        orderId: orderId,
        token: token,
      );

      if (response['status'] == 'ok') {
        // Thành công: Hiển thị thông báo
        Get.snackbar(
          'Thành công',
          'Đơn hàng đã được gửi!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        throw Exception(response['message'] ?? 'Lỗi không xác định.');
      }
    } catch (e) {
      // Xử lý lỗi
      Get.snackbar(
        'Lỗi',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Gọi _submitOrder ngay khi SuccessScreen được khởi tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _submitOrder();
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: CSSpacinngStyle.paddingWithAppBarHeight * 2,
          child: Column(
            children: [
              /// Image
              Image(
                image: AssetImage(image),
                width: CSHelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: CSSize.spaceBtwSections),

              /// Title & SubTitle
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSSize.spaceBtwItems),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: CSSize.spaceBtwSections),

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text(CSText.Continue),
                ),
              ), // SizedBox
            ],
          ), // Column
        ), // Padding
      ), // SingleChildScrollView
    ); // Scaffold
  }
}
