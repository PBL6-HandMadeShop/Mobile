import 'dart:convert';
import 'package:craftshop2/features/authencation/controllers/login_controller/login_controller.dart';
import 'package:craftshop2/features/authencation/screens/password_configuration/forget_password.dart';
import 'package:craftshop2/features/authencation/screens/signUp/sign_up.dart';
import 'package:craftshop2/features/shop/screens/home/home.dart';
import 'package:craftshop2/navigation_menu.dart';
import 'package:craftshop2/utils/constants/texts.dart';
import 'package:craftshop2/utils/local_storage/storage_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';

class CSLoginForm extends StatefulWidget {
  const CSLoginForm({Key? key}) : super(key: key);

  @override
  State<CSLoginForm> createState() => _CSLoginFormState();
}

class _CSLoginFormState extends State<CSLoginForm> {
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      final data = {
        'username': username,
        'password': password,
      };

      try {
        // Gọi hàm đăng nhập từ LoginController
        await _loginController.loginUser(data);
        // Assuming the response is handled inside the controller
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }

      Get.to(() =>NavigationMenu());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: CSSize.spaceBtwSections),
        child: Column(
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right),
                labelText: CSText.username,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your username';
                }
                return null;
              },
            ),
            const SizedBox(height: CSSize.spaceBtwInputFields),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Iconsax.password_check),
                labelText: CSText.password,
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              obscureText: !_isPasswordVisible,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: CSSize.spaceBtwInputFields / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: true, onChanged: (value) {}),
                    const Text(CSText.rembemberMe),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(() => const ForgetPassword()),
                  child: const Text(CSText.forgotPassword),
                ),
              ],
            ),
            const SizedBox(height: CSSize.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _login,
                child: const Text(CSText.signIn),
              ),
            ),
            const SizedBox(height: CSSize.spaceBtwItems),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Get.to(() => const SignUpScreen()),
                child: const Text(CSText.createAccount),
              ),
            ),
            const SizedBox(height: CSSize.spaceBtwSections),
          ],
        ),
      ),
    );
  }
}