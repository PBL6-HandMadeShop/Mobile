import 'package:craftshop2/features/shop/screens/store/widget/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../common/brand/card_brand.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tab_bar.dart';
import '../../../../common/widgets/custom_shape/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/http/api_service.dart';
import '../brand/all_brands.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  _Store createState() => _Store();
}

class _Store extends State<Store> {
  final API_Services api_services = API_Services();
  Map<String, dynamic>? productPage1;
  Map<String, dynamic>? productPage2;
  Map<String, dynamic>? productPage3;
  Map<String, dynamic>? productPage4;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProductTypes();
  }

  Future<void> _loadProductTypes() async {
    try {
      Map<String, dynamic> fetchedData1 = await api_services.fetchProducts(page: 0, size: 10);
      Map<String, dynamic> fetchedData2 = await api_services.fetchProducts(page: 1, size: 10);
      Map<String, dynamic> fetchedData3 = await api_services.fetchProducts(page: 2, size: 10);
      Map<String, dynamic> fetchedData4 = await api_services.fetchProducts(page: 3, size: 10);

      setState(() {
        productPage1 = fetchedData1;
        productPage2 = fetchedData2;
        productPage3 = fetchedData3;
        productPage4 = fetchedData4;
      });
    } catch (e) {
      print('Error fetching products: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                expandedHeight: 200,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(CSSize.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // search bar
                      const SizedBox(height: CSSize.spaceBtwSections),
                      const CSSearchContainer(
                        text: "Search in store",
                        showBorder: true,
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      // const SizedBox(height: CSSize.spaceBtwSections),

                      // // featured brand
                      // CSSectionHeading(
                      //   title: "Featured Brands",
                      //   onPressed: () => Get.to(() => const AllBrandsScreen()),
                      // ),
                      // const SizedBox(height: CSSize.spaceBtwItems / 1.5),

                      // CSGridLayout(
                      //   itemCount: 4,
                      //   mainAxisExtent: 80,
                      //   itemBuilder: (_, index) {
                      //     return const CSBrandCard(
                      //       showBorder: false,
                      //     );
                      //   },
                      // ),
                    ],
                  ),
                ),
                // tab-bar
                bottom: CSTabBar(tabs: [
                  const Tab(child: Text('Default Name')),
                  const Tab(child: Text("Sculpture")),
                  const Tab(child: Text("Painting")),
                  const Tab(child: Text("Weaving")),
                ]),
              ),
            ];
          },
          body: productPage1 == null || productPage2 == null || productPage3 == null || productPage4 == null
              ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
              : TabBarView(
            children: [
              CsCategoryTab(productPage: productPage1),  // Pass the data for Default Name tab
              CsCategoryTab(productPage: productPage2),  // Pass the data for Sculpture tab
              CsCategoryTab(productPage: productPage3),  // Pass the data for Painting tab
              CsCategoryTab(productPage: productPage4),  // Pass the data for Weaving tab
            ],
          ),
        ),
      ),
    );
  }
}
