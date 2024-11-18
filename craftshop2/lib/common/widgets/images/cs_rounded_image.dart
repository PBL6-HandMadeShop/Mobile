import 'dart:typed_data';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CSRoundedImage extends StatelessWidget {
  const CSRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = true,
    this.border,
    this.backgroundColor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = 8.0,
  });

  final double? width, height;
  final dynamic imageUrl;
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
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: ClipRRect(
          borderRadius: applyImageRadius ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
          child: imageUrl is Uint8List && imageUrl.isNotEmpty
              ? Image.memory(imageUrl as Uint8List, fit: fit ?? BoxFit.cover)
              : isNetworkImage && imageUrl is String && imageUrl.isNotEmpty
              ? CachedNetworkImage(
            imageUrl: imageUrl as String,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: fit ?? BoxFit.cover,
          )
              : imageUrl is String && !isNetworkImage
              ? Image.file(File(imageUrl), fit: fit ?? BoxFit.cover)
              : Icon(Icons.error),
        ),
      ),
    );
  }
}
