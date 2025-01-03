import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shape/containers/circular_container.dart';
import '../../../../../common/widgets/images/cs_rounded_image.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/home_controller.dart';

class CSPromoSlider extends StatelessWidget {
  const CSPromoSlider({
    super.key, required this.banners,
  });
  final List<dynamic> banners;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            onPageChanged: (index, _) => controller.updatePageIndicator(index),
    ),
          items: banners.map((url) =>  CSRoundedImage(imageUrl: url),).toList(),),
        const SizedBox(height: CSSize.spaceBtwItems),
        Center(
          child: Obx(
            () => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 0; i < 6; i++)
                  CSCircularContainer(
                    width: 20,
                    height: 4,
                    margin: const EdgeInsets.only(right: 10),
                    backgroundColor: controller.carousalCurrentIndex.value == i ? CSColors.primaryColor:CSColors.grey,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
