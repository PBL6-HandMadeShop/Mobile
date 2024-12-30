import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:typed_data';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/http/api_service.dart';
import '../../layouts/grid_layout.dart';
import '../product_cart/product_cart_vertical.dart';

class CSSortableProducts extends StatefulWidget {
  const CSSortableProducts({
    super.key,
    required this.productPagePopular,
  });
  final List<dynamic>? productPagePopular;

  @override
  _CSSortableProducts createState() => _CSSortableProducts();
}

class _CSSortableProducts extends State<CSSortableProducts> {
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  List<dynamic>? productInfo;
  List<dynamic>? productReview;
  List<dynamic> filteredProducts = [];
  List<dynamic> awaitfilteredProducts = [];

  final TextEditingController _searchNameController = TextEditingController();
  final TextEditingController _searchOriginController = TextEditingController();
  bool isLoading = true;

  // Biến dùng cho tìm kiếm
  String searchKey = ""; // Từ khóa tìm kiếm
  RangeValues priceRange = const RangeValues(0, 1000000); // Khoảng giá mặc định
  String origin = ""; // Nguồn gốc sản phẩm

  @override
  void initState() {
    super.initState();
    _applyFilter(); // Áp dụng bộ lọc ban đầu
  }

  void _applyFilter() async {
    setState(() {
      searchKey = _searchNameController.text.trim();
      origin = _searchOriginController.text.trim();
      isLoading = true; // Bật trạng thái loading
    });

    try {
      // Lấy token từ FlutterSecureStorage
      final token = await storage.read(key: 'session_token');
      if (token == null || token.isEmpty) {
        throw Exception("Token is missing");
      }

      // Gọi API để tìm kiếm sản phẩm
      final response = await api_services.searchProducts(
        token,
        searchKey: searchKey,
        minPrice: priceRange.start,
        maxPrice: priceRange.end,
        origin: origin.isNotEmpty ? origin : null,
      );

      setState(() {
        if (response['status'] == 'ok') {
          // Lấy danh sách sản phẩm từ `content`
          filteredProducts = List<Map<String, dynamic>>.from(response['content'] ?? []);
        } else {
          filteredProducts = [];
          print('Error fetching products: ${response['message']}');
        }
        filteredProducts = filteredProducts.map((product) {
          product['avatar'] = product['avatarBlob'];
          product.remove('avatarBlob');
          return product;
        }).toList();
        isLoading = false; // Tắt trạng thái loading
      });
    } catch (e) {
      setState(() {
        isLoading = false; // Tắt trạng thái loading
      });
      print('Error in _applyFilter: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search Form
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Search Box
              TextField(
                controller: _searchNameController,
                decoration: InputDecoration(
                  labelText: 'Search by Name',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        // Cập nhật searchKey trước khi gọi _applyFilter()
                        searchKey = _searchNameController.text;
                        _applyFilter();
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {
                        searchKey = "";
                        _applyFilter(); // Reset và gọi lại bộ lọc
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchKey = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Price Range Slider
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Filter by Price Range:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RangeSlider(
                    values: priceRange,
                    min: 0,
                    max: 2000000, // Giá tối đa giả định
                    divisions: 20, // Số bước trượt
                    labels: RangeLabels(
                      priceRange.start.toStringAsFixed(0),
                      priceRange.end.toStringAsFixed(0),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        priceRange = values;
                        _applyFilter();
                      });
                    },
                  ),
                ],
              ),

              // Origin Filter
              TextField(
                controller: _searchOriginController,
                decoration: InputDecoration(
                  labelText: 'Search by Origin',
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        origin = _searchOriginController.text;
                        _applyFilter(); // Gọi lại bộ lọc
                      });
                    },
                  ),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      setState(() {
                        origin = "";
                        _applyFilter(); // Reset và gọi lại bộ lọc
                      });
                    },
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    origin = value;
                  });
                },
              ),
            ],
          ),
        ),

        const SizedBox(height: CSSize.spaceBtwSections),

        // Danh sách sản phẩm
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          )
        else
          CSGridLayout(
            itemCount: filteredProducts.length,
            itemBuilder: (_, index) {
              final product = filteredProducts[index];
              return CSProductCardVertical(
                productData: product, // Truyền dữ liệu sản phẩm
              );
            },
          ),
      ],
    );
  }
}

