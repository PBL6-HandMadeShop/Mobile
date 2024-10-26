
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_string.dart';
import '../../../utils/constants/sizes.dart';

class CSSocialButtons extends StatelessWidget {
  const CSSocialButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(border: Border.all(color: CSColors.grey), borderRadius: BorderRadius.circular(100)),
            child: IconButton(onPressed: (){}, icon: const Image(
              width: CSSize.iconMd,
              height: CSSize.iconMd,
              image: AssetImage(CSImage.googleLogo),
            )
            )
        ),
        const SizedBox(width: CSSize.spaceBtwItems,),
      ],
    );
  }
}