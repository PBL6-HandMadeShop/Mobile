import 'package:carousel_slider/carousel_slider.dart';
import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/features/shop/screens/home/widgets/home_categories.dart';
import 'package:craftshop2/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/image_string.dart';
import 'package:craftshop2/utils/constants/texts.dart';
import 'package:craftshop2/utils/device/device_utility.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/custom_shape/containers/circular_container.dart';
import '../../../../common/widgets/custom_shape/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shape/containers/search_container.dart';
import '../../../../common/widgets/custom_shape/curved_edges/curved_edges.dart';
import '../../../../common/widgets/custom_shape/curved_edges/curved_edges_widget.dart';
import '../../../../common/widgets/image_text_widgets/vertical_img_text.dart';
import '../../../../common/widgets/images/cs_rounded_image.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/products/product_cart/product_cart_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import 'widgets/home_appbar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            const CSPrimaryHeaderContainer(
              child: Column(
                children: [
                  CSHomeAppBar(),
                  SizedBox(height: CSSize.spaceBtwSections),

                  /// ---SEARCH BAR
                  CSSearchContainer(text: "Search something ..."),
                  SizedBox(height: CSSize.spaceBtwSections),
                  Padding(
                    padding: EdgeInsets.only(left: CSSize.defaultSpace),
                    child: Column(
                      children: [
                        CSSectionHeading(
                          title: 'Popular Catagories',
                          textColor: CSColors.white,
                        ),
                        SizedBox(height: CSSize.spaceBtwItems),

                        /// Categories
                        CSHomeCategories(),
                      ],
                    ),
                  )

                  /// Categories
                ],
              ),
            ),
            // Body
            Padding(
                padding: const EdgeInsets.all(CSSize.defaultSpace),
                child: Column(
                  children: [

                    /// Promo Slider
                    const CSPromoSlider(banners: [
                      CSImage.promoBanner1,
                      CSImage.promoBanner2,
                      CSImage.promoBanner3
                    ],),

                    /// popular pproduct
                    const SizedBox(height: CSSize.spaceBtwSections),
                    CSGridLayout(itemCount: 2,
                    itemBuilder: (_,index) => const CSProductCardVertical(),),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}




