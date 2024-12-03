import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        title: const Text("Checkout Payment"),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}