import 'package:craftshop2/features/shop/screens/store/widget/category_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/appbar/tab_bar.dart';
import '../../../../common/widgets/custom_shape/containers/search_container.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/http/api_service.dart';

class Store extends StatefulWidget {
  const Store({super.key});

  @override
  _Store createState() => _Store();
}

class _Store extends State<Store> {
  final API_Services api_services = API_Services();
  Map<String, dynamic> productPage = {}; // Map to hold product page
  List<Map<String, dynamic>> productPages = []; // List to hold product pages

  bool isLoading = true;
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadProductTypes();
  }

  // Hàm load các loại sản phẩm từ API
  Future<void> _loadProductTypes() async {
    try {
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic> fetchedData1 = await api_services.getProductTypesPage(size: 100, token: token!);

      if (!mounted) return; // Kiểm tra nếu widget còn tồn tại

      setState(() {
        // Load all the 'content' from fetchedData1 into productPages list
        productPages = List<Map<String, dynamic>>.from(fetchedData1['content'] ?? []);
      });
    } catch (e) {
      if (!mounted) return; // Kiểm tra nếu widget còn tồn tại
      print('Error fetching products: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: productPages.length, // Dynamically set the number of tabs based on productPages length
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
                    children: const [
                      SizedBox(height: CSSize.spaceBtwSections),
                      CSSearchContainer(
                        text: "Search something ...",
                      ),
                    ],
                  ),
                ),

                bottom: CSTabBar(
                  tabs: productPages.map<Widget>((productPage) {
                    return Tab(child: Text('${productPage['name']}' ?? 'Unnamed Tab'));
                  }).toList(), // Dynamically create tabs from productPages
                ),
              ),
            ];
          },
          body: productPages.isEmpty
              ? const Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
              : TabBarView(
            children: productPages.map<Widget>((productPage) {
              return CsCategoryTab(productPage: productPage); // Pass each productPage to CsCategoryTab
            }).toList(), // Dynamically create TabBarView content

          ),
        ),
      ),
    );
  }
}