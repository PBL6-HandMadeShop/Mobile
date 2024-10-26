
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class CSTermAndConditionCheckBox extends StatelessWidget {
  const CSTermAndConditionCheckBox({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child:
            Checkbox(value: true, onChanged: (value) {})),
        const SizedBox(
          width: CSSize.spaceBtwItems,
        ),
        Text.rich(TextSpan(
          children: [
            TextSpan(
                text: '${CSText.iAgreeTo} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${CSText.privacyPolicy} ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(
                    color: dark
                        ? CSColors.white
                        : CSColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: dark
                        ? CSColors.white
                        : CSColors.primaryColor)),
            TextSpan(
                text: '${CSText.and} ',
                style: Theme.of(context).textTheme.bodySmall),
            TextSpan(
                text: '${CSText.termOfUse} ',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .apply(
                    color: dark
                        ? CSColors.white
                        : CSColors.primaryColor,
                    decoration: TextDecoration.underline,
                    decorationColor: dark
                        ? CSColors.white
                        : CSColors.primaryColor)),
          ],
        ))
      ],
    );
  }
}