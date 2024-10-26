
import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class CSLoginHeader extends StatelessWidget {
  const CSLoginHeader({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? CSImage.darkAppLogo: CSImage.lightAppLogo),),
        Text(CSText.loginTitle, style: Theme.of(context).textTheme.headlineMedium,),
        const SizedBox(height: CSSize.sm,),
        Text(CSText.loginSubtitle, style: Theme.of(context).textTheme.bodyMedium,),

      ],
    );
  }
}