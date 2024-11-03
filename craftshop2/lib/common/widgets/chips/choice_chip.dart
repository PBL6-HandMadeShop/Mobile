import 'package:craftshop2/common/widgets/custom_shape/containers/circular_container.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class CSChoicChip extends StatelessWidget {
  const CSChoicChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = CSHelperFunctions.getColor(text) != null ;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label:isColor ? const SizedBox() : Text(text),
        selected:selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? CSColors.white : null),
        avatar: isColor ? CSCircularContainer(width: 50, height: 50, backgroundColor: CSHelperFunctions.getColor(text)!) : null,
        labelPadding: isColor ? const EdgeInsets.all(0) : null,
        padding: isColor ? const EdgeInsets.all(0) : null,
        shape: isColor ? const CircleBorder() : null,
        backgroundColor:isColor ? CSHelperFunctions.getColor(text)! : null,
      ),
    );
  }
}