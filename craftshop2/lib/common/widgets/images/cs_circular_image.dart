import 'dart:typed_data'; // Để làm việc với Uint8List
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class CSCircularImage extends StatelessWidget {
  const CSCircularImage({
    super.key,
    this.fit = BoxFit.cover,
    required this.image,
    this.isNetworkImage = false,
    this.overlayColor,
    this.backgroundColor,
    this.width = 56,
    this.height = 56,
    this.padding = CSSize.sm,
  });

  final BoxFit? fit;
  final dynamic image; // Hỗ trợ String (asset/network) và Uint8List (memory)
  final bool isNetworkImage;
  final Color? overlayColor;
  final Color? backgroundColor;
  final double width, height, padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor ??
            (CSHelperFunctions.isDarkMode(context) ? CSColors.dark : CSColors.white),
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipOval(
        child: image is Uint8List
            ? Image.memory(
          image as Uint8List,
          fit: fit ?? BoxFit.cover,
          color: overlayColor,
        )
            : CachedNetworkImage(
          imageUrl: isNetworkImage ? image as String : '',
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
          fit: fit ?? BoxFit.cover,
          color: overlayColor,
        ),
      ),
    );
  }
}
