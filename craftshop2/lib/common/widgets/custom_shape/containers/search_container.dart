import 'package:flutter/material.dart';

class CSSearchContainer extends StatefulWidget {
  final String text;
  final bool showBorder;
  final bool showBackground;
  final EdgeInsets padding;
  final ValueChanged<String> onSearch;

  const CSSearchContainer({
    Key? key,
    required this.text,
    this.showBorder = true,
    this.showBackground = true,
    this.padding = const EdgeInsets.all(8.0),
    required this.onSearch,
  }) : super(key: key);

  @override
  _CSSearchContainerState createState() => _CSSearchContainerState();
}

class _CSSearchContainerState extends State<CSSearchContainer> {
  final TextEditingController _searchController = TextEditingController();

  void _performSearch() {
    if (_searchController.text.trim().isNotEmpty) {
      widget.onSearch(_searchController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.showBackground ? Colors.grey[200] : Colors.transparent,
        border: widget.showBorder ? Border.all(color: Colors.grey) : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: widget.text,
                border: InputBorder.none,
              ),
              onSubmitted: (_) => _performSearch(), // Kích hoạt tìm kiếm khi nhấn Enter
            ),
          ),
          IconButton(
            icon: Icon(Icons.search, color: Colors.blue),
            onPressed: _performSearch, // Kích hoạt tìm kiếm khi nhấn nút
          ),
        ],
      ),
    );
  }
}
