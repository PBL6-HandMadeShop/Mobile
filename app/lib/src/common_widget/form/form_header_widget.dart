
import 'package:flutter/material.dart';

import '../../constants/colors.dart';



class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    super.key,
    this.imgColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTile,
    this.imgHeight = 0.2,
    this.textAlign,
    this.crossAxisAlignment = CrossAxisAlignment.start,
  });
  final Color? imgColor;
  final double? imgHeight;
  final double? heightBetween;
  final String  image, title, subTile;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(image),
          height: size.height * 0.2,
        ),
        SizedBox(height: heightBetween,),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: secondaryColor,
            fontSize: 40.0
          )

        ),
        Text(
          subTile,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: secondaryColor,
            fontSize: 20.0),
        ),
      ],
    );
  }
}