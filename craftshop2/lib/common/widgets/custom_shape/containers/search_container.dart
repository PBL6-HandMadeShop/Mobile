import 'package:craftshop2/features/shop/screens/search/search_screen.dart';
import 'package:craftshop2/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class CSSearchContainer extends StatefulWidget {
  final String text;

  const CSSearchContainer({
    super.key,
    required this.text,
  });

  @override
  _CSSearchContainerState createState() => _CSSearchContainerState();
}

class _CSSearchContainerState extends State<CSSearchContainer> {
  // Khởi tạo TextEditingController
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Đặt giá trị mặc định

  }

  @override
  void dispose() {
    // Đừng quên giải phóng TextEditingController khi không cần nữa
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: CSColors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController, // Gắn controller
              decoration: InputDecoration(
                hintText: widget.text,
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            // Khi nhấn vào nút search, lấy giá trị từ _searchController.text
            onPressed: () {
              final searchQuery = _searchController.text.trim();
              if (searchQuery.isNotEmpty) {
                Get.to(() => SearchResultScreen(searchQuery: searchQuery));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please enter a search query')),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}




