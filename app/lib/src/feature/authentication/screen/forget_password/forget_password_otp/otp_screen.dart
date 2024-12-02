import 'package:HandcraftShop/src/constants/size.dart';
import 'package:HandcraftShop/src/constants/text_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget{
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(defaultSize),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(otpTitle, style: GoogleFonts.montserrat(
              fontSize: 80,
              fontWeight: FontWeight.bold,
            ),),
             Text(otpSubtitle.toUpperCase(), style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 40.0),
            Text(otpMessage, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 20.0),
            OtpTextField(
              numberOfFields: 4,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code){print("OTP is => $code");},
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
                child: ElevatedButton(onPressed: (){}, child: const Text("Verify"))),
          ],
        ),
      ),
    );
  }

}