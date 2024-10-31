import 'package:flutter/cupertino.dart';

import '../../../utils/constants/sizes.dart';

class CSRoundedImage extends StatelessWidget {
  const CSRoundedImage({
    super.key,
    this.width,
    this.height ,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding ,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = CSSize.md,
  });

  final double? width, height;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundColor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
            border: border,
            color: backgroundColor,
            borderRadius: BorderRadius.circular(CSSize.md)),
        child: ClipRRect(
            borderRadius:applyImageRadius? BorderRadius.circular(CSSize.md): BorderRadius.zero,
            child: Image(
              image: isNetworkImage ? NetworkImage(imageUrl): AssetImage(imageUrl),
              fit: fit,
            )),
      ),
    );
  }
}