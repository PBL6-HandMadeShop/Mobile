import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:craftshop2/utils/http/api_service.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:typed_data';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import '../../../../../common/widgets/icons/cs_circular_icon.dart';
import '../../../../../common/widgets/images/cs_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';

class CSProductImageSlider extends StatefulWidget {
  const CSProductImageSlider({
    super.key, this.avatarBlob,
    required this.productData,
  });

  final Uint8List? avatarBlob;
  final Map<String, dynamic> productData;

  @override
  State<CSProductImageSlider> createState() => _CSProductImageSliderState();
}

class _CSProductImageSliderState extends State<CSProductImageSlider> {
  List<Uint8List> imageList = [];
  final API_Services api_services = API_Services();
  @override
  void initState() {
    super.initState();
    _loadImages();
  }
  List<String> getImageBlobIds(Map<String, dynamic> productData) {
    print("productData: $productData");  // In toàn bộ productData để kiểm tra
    final List<dynamic>? imageBlobs = productData['imageBlobs'];
    if (imageBlobs == null || imageBlobs.isEmpty) {
      print("No imageBlobs found");
      return [];
    }
    print("imageBlobs: $imageBlobs");
    return imageBlobs.map((blob) => blob['id'] as String).toList();
  }


  Future<List<Uint8List>> fetchImageBlobs(List<String> imageIds) async {
    List<Uint8List> imageList = [];
    for (final id in imageIds) {
      try {
        final image = await api_services.downloadProductImage(id);
        imageList.add(image!);
      } catch (e) {
        debugPrint('Error downloading image with id $id: $e');
      }
    }
    return imageList;
  }

  Future<void> _loadImages() async {
    final imageIds = getImageBlobIds(widget.productData);
    final images = await fetchImageBlobs(imageIds);
    setState(() {
      imageList = images;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);
    return CSCurvedEdgeWidget(
      child: Container(
        color: dark ? CSColors.darkerGrey : CSColors.light,
        child: Stack(
          children: [
            // Main Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(CSSize.productImageRadius * 2),
                child: Center(
                  child: CSRoundedImage(
                    imageUrl: widget.avatarBlob,
                    applyImageRadius: true,
                  ),
                ),
              ),
            ),

            // Image Slider
            Positioned(
              right: 0,
              bottom: 30,
              left: CSSize.defaultSpace,
              child: SizedBox(
                height: 80,
                // child: ListView.separated(
                //   shrinkWrap: true,
                //   scrollDirection: Axis.horizontal,
                //   physics: const AlwaysScrollableScrollPhysics(),
                //   itemBuilder: (_, index) {
                //     final image = imageList.isNotEmpty ? imageList[index] : null;
                //     return CSRoundedImage(
                //       width: 80,
                //       backgroundColor: dark ? CSColors.dark : CSColors.light,
                //       border: Border.all(color: CSColors.primaryColor),
                //       padding: const EdgeInsets.all(CSSize.sm),
                //       imageUrl: image,
                //     );
                //   },
                //   separatorBuilder: (_, __) =>
                //   const SizedBox(width: CSSize.spaceBtwItems),
                //   itemCount: imageList.length,
                // ),
                child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (_, index) => CSRoundedImage(
                      width:  80,
                      backgroundColor: dark ? CSColors.dark : CSColors.light,
                      border: Border.all(color: CSColors.primaryColor),
                      padding: const EdgeInsets.all(CSSize.sm),
                      imageUrl: CSImage.product3,
                    ),
                    separatorBuilder: (_,__) => const SizedBox(width: CSSize.spaceBtwItems),
                    itemCount: 4
                ),
              ),
            ),

            // Appbar Icons
            const CSAppBar(
              showBackArrow: true,
              actions: [
                CSCircularlIcon(icon: Iconsax.heart5, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
