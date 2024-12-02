import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text_widgets/vertical_img_text.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../sub_category/sub_categories.dart';

class CSHomeCategories extends StatefulWidget {
  const CSHomeCategories({
    super.key,
    required this.productPages,
  });

  final List<Map<String, dynamic>> productPages;

  @override
  _CSHomeCategories createState() => _CSHomeCategories();
}

class _CSHomeCategories extends State<CSHomeCategories> {

  @override
  Widget build(BuildContext context) {
    if (widget.productPages.isEmpty) {
      return const SizedBox.shrink(); // Render nothing if no data
    }

    return SizedBox(
      height: 80,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.productPages.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          final productData = widget.productPages[index];
          return productData != null
              ? CSVerticalImageText(
            image: CSImage.bracelet,
            title: productData['name'] ?? 'Unknown',
            onTap: () => Get.to(
                  () => SubCategoriesScreen(productPage: productData),
            ),
          )
              : const SizedBox.shrink();
        },
      ),
    );
  }
}
