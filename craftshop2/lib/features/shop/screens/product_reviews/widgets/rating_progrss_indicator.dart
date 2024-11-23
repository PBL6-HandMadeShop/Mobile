import 'package:craftshop2/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

class CSOverallProductRating extends StatelessWidget {
  final Map<String, dynamic> productReview;
  const CSOverallProductRating({
    super.key, required this.productReview,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex:3, child: Text(
            productReview["ratings"]?["average"]?.toString() ?? '0',
            style: Theme.of(context).textTheme.displayLarge)),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              CSRatingProgressIndicator(text: '5', value:(productReview["ratings"]?["1"] ?? 0).toDouble(),),
              CSRatingProgressIndicator(text: '4', value:(productReview["ratings"]?["4"] ?? 0).toDouble()),
              CSRatingProgressIndicator(text: '3', value:(productReview["ratings"]?["3"] ?? 0).toDouble()),
              CSRatingProgressIndicator(text: '2', value:(productReview["ratings"]?["2"] ?? 0).toDouble()),
              CSRatingProgressIndicator(text: '1', value:(productReview["ratings"]?["1"] ?? 0).toDouble()),
            ],
          ),
        ),
      ],
    );
  }
}