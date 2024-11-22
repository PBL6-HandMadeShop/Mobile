import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/constants/sizes.dart';

class CSRatingAndShare extends StatelessWidget {
  const CSRatingAndShare({
    super.key, required this.ratingScore, required this.countRating,
  });
  final String ratingScore;
  final String countRating;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        /// Rating
        Row(
          children: [
            Icon(Iconsax.star5, color: Colors.amber, size: 24),
            SizedBox(width: CSSize.spaceBtwItems/2),
            Text.rich(TextSpan(
                children: [
                  TextSpan(text: ratingScore , style: Theme.of(context).textTheme.bodyLarge),
                  TextSpan(text: countRating),
                ]
            )
            )
          ],
        ),

        /// Share Button
        IconButton(onPressed: (){}, icon: const Icon(Icons.share, size: CSSize.iconMd))
      ],
    );
  }
}