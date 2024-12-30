import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../common/widgets/success_screen/success_screen.dart';
import '../../../../navigation_menu.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/http/api_service.dart';
import '../webview/web_view_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<dynamic> cartItems;
  final double totalAmount;

  const CheckoutScreen({super.key, required this.cartItems, required this.totalAmount});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final API_Services _apiServices = API_Services();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  final _formKey = GlobalKey<FormState>();
  String address = '';
  String province = '';
  String city = '';
  String district = '';
  String ward = '';
  double latitude = 0.0;
  double longitude = 0.0;
  String paymentMethod = 'CASH';
  String paymentPlan = 'PREPAY';
  String receivingMethod = 'AT_STORE';
  bool removeCartItems = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader("Thông tin giao hàng"),
              const SizedBox(height: 10),
              _buildTextField("Địa chỉ", (value) => address = value ?? '', "Vui lòng nhập địa chỉ"),
              _buildTextField("Tỉnh/Thành phố", (value) => province = value ?? '', "Vui lòng nhập tỉnh/thành phố"),
              _buildTextField("Thành phố/Quận", (value) => city = value ?? '', "Vui lòng nhập thành phố/quận"),
              _buildTextField("Phường/Xã", (value) => ward = value ?? '', "Vui lòng nhập phường/xã"),
              _buildTextField(
                "Kinh độ",
                    (value) => longitude = double.tryParse(value ?? '0') ?? 0.0,
                "Vui lòng nhập kinh độ",
                isNumeric: true,
              ),
              _buildTextField(
                "Vĩ độ",
                    (value) => latitude = double.tryParse(value ?? '0') ?? 0.0,
                "Vui lòng nhập vĩ độ",
                isNumeric: true,
              ),
              const Divider(height: 40),
              _buildSectionHeader("Thông tin thanh toán"),
              const SizedBox(height: 10),
              _buildDropdownField(
                "Phương thức thanh toán",
                paymentMethod,
                ["CASH", "INTERNET_BANKING"],
                    (value) => setState(() => paymentMethod = value!),
              ),
              _buildDropdownField(
                "Kế hoạch thanh toán",
                paymentPlan,
                ["PREPAY", "POSTPAY"],
                    (value) => setState(() => paymentPlan = value!),
              ),
              _buildDropdownField(
                "Cách nhận hàng",
                receivingMethod,
                ["AT_STORE", "VIA_SHIPMENT"],
                    (value) => setState(() => receivingMethod = value!),
              ),
              const SizedBox(height: 20),
              _buildTotalSummary(),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _createOrder,

                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.lightBlue,
                  ),
                  child: const Text("Đặt hàng", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue),
    );
  }

  Widget _buildTextField(String label, Function(String?) onSave, String validationMessage, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
        onSaved: onSave,
        validator: (value) => value!.isEmpty ? validationMessage : null,
      ),
    );
  }

  Widget _buildDropdownField(String label, String currentValue, List<String> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: DropdownButtonFormField<String>(
        value: currentValue,
        items: options.map((value) {
          return DropdownMenuItem(value: value, child: Text(value));
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }

  Widget _buildTotalSummary() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Tổng tiền:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.totalAmount.toStringAsFixed(2)} VNĐ",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.lightBlue),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createOrder() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();

    try {
      // Lấy token từ storage
      String? token = await _storage.read(key: 'session_token');
      if (token == null) {
        throw Exception("Bạn chưa đăng nhập. Vui lòng đăng nhập để tiếp tục.");
      }

      // Tạo chi tiết đơn hàng
      String orderDetails = jsonEncode(
        widget.cartItems.map((item) {
          return {
            'id': item['product']['id'],
            'quantity': item['quantity'].toString(),
          };
        }).toList(),
      );

      // Gửi yêu cầu tạo đơn hàng
      final response = await _apiServices.createOrder(
        paymentMethod: paymentMethod,
        paymentPlan: paymentPlan,
        address: address,
        province: province,
        city: city,
        district: district,
        ward: ward,
        latitude: latitude,
        longitude: longitude,
        orderDetails: orderDetails,
        receivingMethod: receivingMethod,
        removeCartItems: removeCartItems,
        token: token,
      );

      final responseData = jsonDecode(response['message']);
      if (response['status'] == 'ok') {
        // Lấy orderId trực tiếp từ response
        String orderId = responseData['id'];

        // Nếu thanh toán là Internet Banking + Prepay, thực hiện điều hướng đến trang thanh toán
        if (paymentMethod == 'INTERNET_BANKING' && paymentPlan == 'PREPAY') {
          final paymentResponse = await _apiServices.confirmPaymentUsingVNPAY(
            orderId: orderId,
            token: token,
          );

          if (paymentResponse['status'] == 'ok') {
            String returnURL = paymentResponse['returnUrl'];
            Get.to(() => VNpayPayment(paymentUrl: returnURL));
            return;
          } else {
            throw Exception(paymentResponse['message2'] ?? 'Thanh toán thất bại.');
          }
        } else {
          // Chuyển đến SuccessScreen với `orderId` và `token`
          Get.offAll(() => SuccessScreen(
            image: CSImage.sculpture,
            title: 'Đặt hàng thành công!',
            subTitle: 'Đơn hàng của bạn đã được gửi thành công.',
            onPressed: () => Get.offAll(() => const NavigationMenu()),
            orderId: orderId,
            token: token,
          ));
        }
      } else {
        throw Exception(response['message'] ?? 'Đặt hàng thất bại.');
      }
    } catch (e) {
      Get.snackbar(
        'Lỗi',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// URL lấy ra dùng được rồi nhưng launch nó k chuyển hướng sang web được

// Hàm mở URL trong trình duyệt
  void _launchURL(String url) async {
    final Uri url0 = Uri.parse(url);
    final String chromeUrl = 'googlechrome://navigate?url=$url0';

    if (await canLaunch(chromeUrl)) {
      await launch(chromeUrl);
    } else if (await canLaunch(url0.toString())) {
      await launch(url0.toString());
    } else {
      throw 'Không thể mở URL: $url';
    }
  }


}