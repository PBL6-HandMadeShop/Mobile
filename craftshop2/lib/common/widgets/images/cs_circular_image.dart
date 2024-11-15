import 'dart:typed_data';  // Để làm việc với Uint8List

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
  final dynamic image;  // Chấp nhận cả String (để hiển thị ảnh từ mạng hoặc asset) và Uint8List (ảnh từ bộ nhớ)
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
      child: image is Uint8List // Kiểm tra nếu image là kiểu dữ liệu Uint8List
          ? Image.memory(
        image as Uint8List, // Chuyển đổi sang Uint8List
        fit: fit ?? BoxFit.cover,
        color: overlayColor,
      )
          : Image(
        image: isNetworkImage
            ? NetworkImage(image as String)
            : AssetImage(image as String) as ImageProvider,
        fit: fit ?? BoxFit.cover,
        color: overlayColor,
      ),
    );
  }
}
