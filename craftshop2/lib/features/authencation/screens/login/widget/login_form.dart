
import 'package:craftshop2/utils/http/api_service.dart';
import 'package:craftshop2/features/authencation/screens/password_configuration/forget_password.dart';
import 'package:craftshop2/features/authencation/screens/signUp/sign_up.dart';

import 'package:craftshop2/navigation_menu.dart';
import 'package:craftshop2/utils/constants/texts.dart';

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
  final API_Services _api_services = API_Services();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text.trim();
      final password = _passwordController.text.trim();

      if (username.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username and password cannot be empty')),
        );
        return;
      }
      try {
        // Call the login method from LoginController
        await _api_services.login(username, password);
        // Assuming the response is handled inside the controller
        Get.to(() => NavigationMenu());
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: $e')),
        );
      }
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
//
// import 'dart:convert';
//
// import 'package:craftshop2/features/authencation/screens/password_configuration/forget_password.dart';
// import 'package:craftshop2/features/authencation/screens/signUp/sign_up.dart';
// import 'package:craftshop2/navigation_menu.dart';
// import 'package:craftshop2/utils/constants/texts.dart';
// import 'package:craftshop2/utils/local_storage/storage_utility.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:craftshop2/utils/http/http_client.dart';
//
// import '../../../../../utils/constants/sizes.dart';
//
// class CSLoginform extends StatefulWidget {
//   const CSLoginform({super.key});
//
//   @override
//   _CSLoginformState createState() => _CSLoginformState();
// }
//
// class _CSLoginformState extends State<CSLoginform> {
//   final _formKey = GlobalKey<FormState>();
//   final _usernameController = TextEditingController();
//   final _passwordController = TextEditingController();
//   bool _isPasswordVisible = false;
//   void _login() async {
//     if (_formKey.currentState!.validate()) {
//       final username = _usernameController.text.trim();
//       final password = _passwordController.text.trim();
//
//       // Check if username is not empty
//       if (username.isEmpty) {
//         print('Username cannot be empty');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Username cannot be empty')),
//         );
//         return; // Prevent further processing
//       }
//       final data = {
//         'username': _usernameController.text.trim(),
//         'password': _passwordController.text.trim(),
//       };
//
//       print("Data being sent: $data");
//       try {
//         final response = await CSHttpClient.login(data);
//         print('Login successful: $response');
//
//         // Save user data to local storage
//         if (response['status'] == 'ok') {
//           final userData = response['content'];
//           await CSLocalStorage.saveData('user_data', json.encode(userData)); // Save user data as JSON
//           Get.to(() => const NavigationMenu());
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Login failed: ${response['message']}')),
//           );
//         }
//       } catch (e) {
//         print('Login failed: $e');
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Login failed: $e')),
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Form(
//       key: _formKey,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: CSSize.spaceBtwSections),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: _usernameController,
//               decoration: const InputDecoration(
//                 prefixIcon: Icon(Iconsax.direct_right),
//                 labelText: CSText.username,
//               ),
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your username';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: CSSize.spaceBtwInputFields),
//
//
//             TextFormField(
//               controller: _passwordController,
//               decoration: InputDecoration(
//                 prefixIcon: Icon(Iconsax.password_check),
//                 labelText: CSText.password,
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     _isPasswordVisible ? Iconsax.eye : Iconsax.eye_slash,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       _isPasswordVisible = !_isPasswordVisible;
//                     });
//                   },
//                 ),
//               ),
//               obscureText: !_isPasswordVisible,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Please enter your password';
//                 }
//                 return null;
//               },
//             ),
//             const SizedBox(height: CSSize.spaceBtwInputFields / 2),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Checkbox(value: true, onChanged: (value) {}),
//                     const Text(CSText.rembemberMe),
//                   ],
//                 ),
//                 TextButton(
//                   onPressed: () => Get.to(() => const ForgetPassword()),
//                   child: const Text(CSText.forgotPassword),
//                 ),
//               ],
//             ),
//             const SizedBox(height: CSSize.spaceBtwSections),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: _login,
//                 child: const Text(CSText.signIn),
//               ),
//             ),
//             const SizedBox(height: CSSize.spaceBtwItems),
//             SizedBox(
//               width: double.infinity,
//               child: OutlinedButton(
//                 onPressed: () => Get.to(() => const SignUpScreen()),
//                 child: const Text(CSText.createAccount),
//               ),
//             ),
//             const SizedBox(height: CSSize.spaceBtwSections),
//           ],
//         ),
//       ),
//     );
//   }
// }