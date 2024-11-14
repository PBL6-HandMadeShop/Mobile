import 'package:craftshop2/features/authencation/screens/password_configuration/reset_password.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/constants/texts.dart';
import 'package:craftshop2/utils/http/api_service.dart'; // Thêm import API
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  // Gửi yêu cầu tạo mã thay đổi mật khẩu
  void _sendPasswordResetRequest() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    String email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _errorMessage = "Please enter a valid email.";
        _isLoading = false;
      });
      return;
    }

    final apiService = API_Services();
    final response = await apiService.generatePasswordCode(email);

    setState(() {
      _isLoading = false;
    });
    Get.off(() => const ResetPassword());

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Headings
            Text(CSText.forgotPasswordTitle, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: CSSize.spaceBtwItems),
            Text(CSText.forgotPasswordSubtitle, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: CSSize.spaceBtwSections * 2),

            // Email TextField
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: CSText.email,
                prefixIcon: Icon(Iconsax.direct_right),
              ),
            ),
            const SizedBox(height: CSSize.spaceBtwSections),

            // // Error Message
            // if (_errorMessage != null)
            //   Padding(
            //     padding: const EdgeInsets.only(bottom: CSSize.spaceBtwSections),
            //     child: Text(
            //       _errorMessage!,
            //       style: TextStyle(color: Colors.red),
            //     ),
            //   ),

            // Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _sendPasswordResetRequest, // Disable button if loading
                child: _isLoading
                    ? const CircularProgressIndicator() // Show loading spinner
                    : const Text(CSText.confirmEmail),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
