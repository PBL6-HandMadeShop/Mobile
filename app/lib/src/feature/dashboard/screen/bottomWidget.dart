import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class bottomWidget extends StatelessWidget {
  const bottomWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50, // Adjust the height as needed
      width: MediaQuery.of(context).size.width, // Ensure it spans the full width
      child: CurvedNavigationBar(
        backgroundColor: Color(0xFFFFDC97),
        animationCurve: Curves.linearToEaseOut ,
        items: const [
          Icon(Icons.home_outlined, size: 30, color: Color(0xFFFFC784)),
          Icon(Icons.shopping_cart_outlined, size: 30, color: Color(0xFFFFC784)),
          Icon(Icons.favorite_outline, size: 30, color: Color(0xFFFFC784)),
          Icon(Icons.local_shipping_outlined, size: 30, color: Color(0xFFFFC784)),
        ],
      ),
    );
  }
}