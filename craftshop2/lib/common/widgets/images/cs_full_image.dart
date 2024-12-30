import 'package:flutter/material.dart';
import 'dart:typed_data';

class FullScreenImageSlider extends StatefulWidget {
  final List<Uint8List> imageList;
  final int initialIndex;

  const FullScreenImageSlider({
    super.key,
    required this.imageList,
    required this.initialIndex,
  });

  @override
  State<FullScreenImageSlider> createState() => _FullScreenImageSliderState();
}

class _FullScreenImageSliderState extends State<FullScreenImageSlider> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Đặt nền đen cho Scaffold
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imageList.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                panEnabled: true,
                minScale: 0.5,
                maxScale: 4,
                child: Container( // Thay Center bằng Container
                  width: double.infinity, // Chiều rộng tối đa
                  height: double.infinity, // Chiều cao tối đa
                  child: Image.memory(
                    widget.imageList[index],
                    fit: BoxFit.contain, // Sử dụng BoxFit.contain để lấp đầy
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}