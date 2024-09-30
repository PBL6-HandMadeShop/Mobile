
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/size.dart';
import '../../../../constants/text_string.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: formHeight - 10),
      child: Form(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Email"),
                  hintText: "Enter your email",
                  hintStyle: TextStyle(fontSize: 12),
                  prefixIconColor: secondaryColor,
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),

                  floatingLabelStyle: TextStyle(color: secondaryColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 5, color: secondaryColor),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Full Name"),
                  hintText: "Enter your full name",
                  hintStyle: TextStyle(fontSize: 12),
                  prefixIconColor: secondaryColor,
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(color: secondaryColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 5, color: secondaryColor),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Phone number"),
                  hintText: "Enter your phone number",
                  hintStyle: TextStyle(fontSize: 12),
                  prefixIconColor: secondaryColor,
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(color: secondaryColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 5, color: secondaryColor),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text("Password"),
                  hintText: "Enter your Password",
                  hintStyle: TextStyle(fontSize: 12),
                  prefixIconColor: secondaryColor,
                  prefixIcon: Icon(Icons.fingerprint),
                  border: OutlineInputBorder(),
                  floatingLabelStyle: TextStyle(color: secondaryColor),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 5, color: secondaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(),
                        foregroundColor: whiteColor,
                        backgroundColor: secondaryColor,
                        textStyle: const TextStyle(fontSize: 22),
                        side: const BorderSide(color: secondaryColor),
                      ),
                      child: Text(registerButton.toUpperCase()))),
            ]),
      ),
    );
  }
}