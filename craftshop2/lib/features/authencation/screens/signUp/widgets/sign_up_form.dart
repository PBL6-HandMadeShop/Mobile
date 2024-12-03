
import 'package:craftshop2/features/authencation/screens/login/login.dart';
import 'package:craftshop2/features/authencation/screens/signUp/widgets/term_and_condition.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../../controllers/registration/register_controller.dart';

class CSSignupForm extends StatefulWidget {
  final bool dark;
  const CSSignupForm({required this.dark, super.key});

  @override
  _CSSignupFormState createState() => _CSSignupFormState();
}

class _CSSignupFormState extends State<CSSignupForm> {
  final _formKey = GlobalKey<FormState>();
  final RegisterController _registerController = RegisterController();


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _birthDateController = TextEditingController();
  bool _isMale = false;
  bool _isFemale = false;

  void _handleGenderChange(String gender) {
    setState(() {
      if (gender == 'MALE') {
        _isMale = true;
        _isFemale = false;
      } else if (gender == 'FEMALE') {
        _isMale = false;
        _isFemale = true;
      }
    });
  }

  Future<void> _selectBirthDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        final formattedMonth = picked.month.toString().padLeft(2, '0');
        final formattedDay = picked.day.toString().padLeft(2, '0');
        _birthDateController.text = "[${picked.year},$formattedMonth,$formattedDay]";
      });

    }
  }



  void _register() async {
    if (_formKey.currentState!.validate()) {
      // Tạo dữ liệu đăng ký dưới dạng Map
      final data = {
        'name': _nameController.text.trim(),
        'email': _emailController.text.trim(),
        'phoneNumber': _phoneNumberController.text.trim(),
        'username': _usernameController.text.trim(),
        'gender': _isMale ? 'MALE' : 'FEMALE',
        'birthDate': _birthDateController.text,
      };

      // Gọi hàm đăng ký từ RegisterController
      await _registerController.registerUser(data);

      // Xử lý thành công, ví dụ điều hướng đến trang khác
       Get.to(()=> const LoginScreen());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Iconsax.user),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: CSSize.spaceBtwInputFields),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Iconsax.direct),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!GetUtils.isEmail(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: CSSize.spaceBtwInputFields),
          TextFormField(
            controller: _phoneNumberController,
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              prefixIcon: Icon(Iconsax.call),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          const SizedBox(height: CSSize.spaceBtwInputFields),
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Username',
              prefixIcon: Icon(Iconsax.user_edit),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your username';
              }
              return null;
            },
          ),
          const SizedBox(height: CSSize.spaceBtwInputFields/2),
          Form(
            child: Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Male'),
                    value: _isMale,
                    onChanged: (bool? value) {
                      _handleGenderChange('MALE');
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Female'),
                    value: _isFemale,
                    onChanged: (bool? value) {
                      _handleGenderChange('FEMALE');
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: CSSize.spaceBtwInputFields/2),
          TextFormField(
            controller: _birthDateController,
            decoration: const InputDecoration(
              labelText: 'Birth Date',
              prefixIcon: Icon(Iconsax.calendar),
            ),
            readOnly: true,
            onTap: () => _selectBirthDate(context),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your birth date';
              }
              return null;
            },
          ),
          const SizedBox(height: CSSize.spaceBtwInputFields),
          CSTermAndConditionCheckBox(dark: CSHelperFunctions.isDarkMode(context)),
          const SizedBox(
            height: CSSize.spaceBtwSections,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _register,

              child: const Text(CSText.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
