import 'dart:convert'; // Để parse JSON
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http; // Thư viện http
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../navigation_menu.dart';
import '../../../../utils/constants/sizes.dart';

class VNpayPayment extends StatelessWidget {
  const VNpayPayment({super.key, required this.paymentUrl});
  final String paymentUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Checkout payment',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentTestScreen(paymentUrl: paymentUrl),
    );
  }
}

class PaymentTestScreen extends StatefulWidget {
  const PaymentTestScreen({super.key, required this.paymentUrl});
  final String paymentUrl;

  @override
  State<PaymentTestScreen> createState() => _PaymentTestScreenState();
}

class _PaymentTestScreenState extends State<PaymentTestScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('intent://')) {
              _launchURL(request.url);
              return NavigationDecision.prevent;
            }

            if (request.url.contains('/api/VNPAYReturnHandler')) {
              // Gọi API và xử lý kết quả từ callback URL
              fetchPaymentResult(request.url);
              return NavigationDecision.prevent; // Ngăn WebView load URL
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            if (error.description.contains("ERR_UNKNOWN_URL_SCHEME")) {
              print("Unknown URL scheme: ${error.description}");
            }
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> fetchPaymentResult(String apiUrl) async {
    try {
      // Gửi HTTP GET request tới API
      final response = await http.get(Uri.parse(apiUrl));

      // Kiểm tra mã trạng thái (status code) của response
      if (response.statusCode == 200) {
        // Parse dữ liệu JSON trả về
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Lấy thông tin cần thiết từ JSON
        String? message = data['message'];
        String? orderId = data['content']?['orderId'];
        String? totalPrice = data['content']?['totalPrice'];
        String? transactionId = data['content']?['transactionId'];

        // Điều hướng đến màn hình thành công
        if (message != null && orderId != null && totalPrice != null && transactionId != null) {
          Map<String, dynamic> paymentResult = {
            'message': message,
            'orderId': orderId,
            'totalPrice': totalPrice,
            'transactionId': transactionId,
          };
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSuccessScreen(paymentResult: paymentResult),
            ),
          );
        }
      } else {
        // Xử lý nếu API trả về lỗi
        print("Error: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
      // Xử lý lỗi (như khi mất kết nối mạng)
      print("An error occurred: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}



class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key, required this.paymentResult});
  final Map<String, dynamic> paymentResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment Success"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 100.0,
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Text(
                    "Payment Successful!",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .apply(color: CSColors.black)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20.0),
                Text(
                  "Message: ${paymentResult['message']}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: CSColors.black)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Order ID: ${paymentResult['orderId']}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: CSColors.black)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Total Price: ${paymentResult['totalPrice']}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: CSColors.black)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Transaction ID: ${paymentResult['transactionId']}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .apply(color: CSColors.black)
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const NavigationMenu()),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(CSSize.md),
                      backgroundColor: CSColors.white,
                      side: const BorderSide(color: CSColors.black),
                    ),
                    child: const Text('Back to home', style: TextStyle(color: CSColors.black)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
