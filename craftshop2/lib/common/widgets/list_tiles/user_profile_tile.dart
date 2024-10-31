import 'package:craftshop2/common/widgets/images/cs_circular_image.dart';
import 'package:flutter/material.dart%20';
import 'package:iconsax/iconsax.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/image_string.dart';

class CSUserProfileTile extends StatelessWidget {
  const CSUserProfileTile({
    super.key, required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CSCircularImage(image: CSImage.user, width: 50, height: 50, padding: 0,),
      title: Text('Cristiano' , style: Theme.of(context).textTheme.headlineSmall!.apply(color: CSColors.white)),
      subtitle: Text('support@craftShop.com' , style: Theme.of(context).textTheme.headlineSmall!.apply(color: CSColors.white)),
      trailing: IconButton(onPressed: onPressed, icon: const Icon(Iconsax.edit,color: CSColors.white)),
    );
  }
}