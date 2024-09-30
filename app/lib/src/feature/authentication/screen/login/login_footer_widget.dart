
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/image_string.dart';
import '../../../../constants/size.dart';
import '../../../../constants/text_string.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text("Or"),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(),
              side: BorderSide(color: secondaryColor, width: 2),
            ),
              icon: Image(image: AssetImage(googleImage), width: 20,),
              onPressed: () {}, label: Text("Sign in With Google",style:TextStyle(fontSize: 15))),
        ),
        const SizedBox(height: defaultSize - 20),
        TextButton(onPressed: () {}, child: Text.rich(TextSpan(
          text: loginDontHaveAnAccount,
          style: Theme.of(context).textTheme.bodyMedium,
          children: const [
            TextSpan(
                text: loginCreateAccount,
                style: TextStyle(color: Colors.blue))
          ],
        )
        ))
      ],
    );
  }
}