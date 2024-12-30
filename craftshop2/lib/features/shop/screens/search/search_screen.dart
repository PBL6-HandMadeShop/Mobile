import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cart/product_cart_vertical.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';

class SearchResultScreen extends StatefulWidget {
  final String searchQuery;

  const SearchResultScreen({
    super.key,
    required this.searchQuery,
  });

  @override
  _SearchResultScreen createState() => _SearchResultScreen();
}

class _SearchResultScreen extends State<SearchResultScreen> {
  final API_Services api_services = API_Services();
  List<Map<String, dynamic>> productPages = [];

  final FlutterSecureStorage storage = const FlutterSecureStorage();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSearchProduct();

    // Delay for 10 seconds, then set isLoading to false
    Future.delayed(const Duration(seconds: 8), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  Future<void> _loadSearchProduct() async {
    try {
      print('Search query: ${widget.searchQuery}');
      String? token = await storage.read(key: 'session_token');
      Map<String, dynamic> fetchedData1 =
      await api_services.searchProducts(
        token!,
        searchKey: widget.searchQuery,
      );

      if (!mounted) return;

      setState(() {
        productPages = List<Map<String, dynamic>>.from(fetchedData1['content'] ?? []);
        productPages = productPages.map((product) {
          product['avatar'] = product['avatarBlob'];
          product.remove('avatarBlob');
          return product;
        }).toList();
        isLoading = false; // Tắt loading sau khi load xong dữ liệu
      });
    } catch (e) {
      if (!mounted) return;
      print('Error fetching products: $e');
      setState(() {
        isLoading = false; // Tắt loading nếu có lỗi
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Results for "${widget.searchQuery}"'),
      ),
      body: isLoading
          ? const Center(
        child: CircularProgressIndicator(),
      )
          : productPages.isEmpty
          ? const Center(child: Text('No products found'))
          : ListView(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        children: [
          // Section Heading
          CSSectionHeading(
            title: "You might search",
            showActionButton: false,
            onPressed: () {},
          ),
          const SizedBox(height: CSSize.spaceBtwItems),

          // Product Grid Layout
          CSGridLayout(
            itemCount: productPages.length,
            itemBuilder: (_, index) {
              final product = productPages[index];
              return product != null
                  ? CSProductCardVertical(productData: product)
                  : const SizedBox.shrink(); // Fallback if no product
            },
          ),

          const SizedBox(height: CSSize.spaceBtwSections),
        ],
      ),
    );
  }
}