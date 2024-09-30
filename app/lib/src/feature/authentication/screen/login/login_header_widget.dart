
import 'package:flutter/material.dart';

import '../../../../constants/image_string.dart';
import '../../../../constants/text_string.dart';

class LoginHeaderWidget extends StatelessWidget {
  const LoginHeaderWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(logoImage),
          height: size.height * 0.2,
        ),
        Text(
          loginTitle,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        Text(
          loginSubtitle,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }
}