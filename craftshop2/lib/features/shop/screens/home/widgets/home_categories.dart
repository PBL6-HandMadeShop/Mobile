import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';



import '../../../../../common/widgets/image_text_widgets/vertical_img_text.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../sub_category/sub_categories.dart';


class CSHomeCategories extends StatelessWidget {
  const CSHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return CSVerticalImageText(
            image: CSImage.bracelet,
            title: 'Bracelet Category',
            onTap: () => Get.to(() => const SubCategoriesScreen()),
          );
        },
      ),
    );
  }
}