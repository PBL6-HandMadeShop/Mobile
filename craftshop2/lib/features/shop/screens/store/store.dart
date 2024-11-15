import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/common/widgets/appbar/tab_bar.dart';
import 'package:craftshop2/common/widgets/custom_shape/containers/search_container.dart';
import 'package:craftshop2/common/widgets/layouts/grid_layout.dart';
import 'package:craftshop2/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:craftshop2/features/shop/controllers/product_controller.dart';
import 'package:craftshop2/features/shop/controllers/product_type_controller.dart';
import 'package:craftshop2/features/shop/screens/store/widget/category_tab.dart';

import 'package:craftshop2/utils/constants/colors.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/brand/card_brand.dart';
import '../../controllers/product_type_page_controller.dart';
import '../brand/all_brands.dart';

class Store extends StatelessWidget {
  const Store({super.key});

  @override
  Widget build(BuildContext context) {
    final productController = Get.put(ProductController());
    final productTypeController = Get.put(ProductTypePageController());
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: CSAppBar(
            title: Text(
              "Store",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: [CSCartCounterIcon(onPressed: () {})],
          ),
          body: NestedScrollView(
            headerSliverBuilder: (_, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: CSHelperFunctions.isDarkMode(context)
                      ? CSColors.dark
                      : CSColors.white,
                  expandedHeight: 440,

                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(CSSize.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        // search bar
                        const SizedBox(
                          height: CSSize.spaceBtwSections,
                        ),
                        const CSSearchContainer(
                          text: "Search in store",
                          showBorder: true,
                          showBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(
                          height: CSSize.spaceBtwSections,
                        ),

                        // featured brand
                        CSSectionHeading(
                          title: "Featured Brands",
                          onPressed: () => Get.to(() => const AllBrandsScreen()),
                        ),
                        const SizedBox(
                          height: CSSize.spaceBtwItems / 1.5,
                        ),

                        CSGridLayout(
                            itemCount: 4,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              return const CSBrandCard(
                                showBorder: false,
                              );
                            })
                      ],
                    ),
                  ),

                  /// tab-bar
                  bottom: CSTabBar(
                    tabs: productTypeController.productTypes.map((productType) {
                      return Tab(
                        child: Text(productType['name'] ?? 'Unknown'),
                      );
                    }).toList(),
                  ),
                ),
              ];
            },
            body: const TabBarView(children: [
              CsCategoryTab(),
              CsCategoryTab(),
              CsCategoryTab(),
              CsCategoryTab(),
            ]),
          ),
        ));
  }
}
