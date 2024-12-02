import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CSVerticalImageText extends StatelessWidget {
  const CSVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = CSColors.white,
    this.backgroundColor = CSColors.white,
    this.onTap,
  });
  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: CSSize.spaceBtwItems),
        child: Column(
          children: [
            //circulat icon
            Container(
              width: 56,
              height: 56,
              padding: const EdgeInsets.all(CSSize.sm),
              decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius:
                  BorderRadius.circular(100)),
              child: Center(
                child: Image(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    color: CSColors.dark),
              ),
            ),
            const SizedBox(
                height: CSSize.spaceBtwItems / 2),
            Flexible(
              child: SizedBox(
                  width: 55,
                  child: Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .apply(color: textColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}