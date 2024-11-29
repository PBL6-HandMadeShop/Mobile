import 'package:craftshop2/features/shop/screens/product_reviews/widgets/rating_progrss_indicator.dart';
import 'package:craftshop2/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:flutter/material.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../utils/constants/sizes.dart';


class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key, required this.productReview});
  final Map<String, dynamic> productReview;

  String _getAmountReview({
    required Map<String, dynamic> productReview,
  }) {
    final count = productReview['content']?.length ?? 0;
    return count == 0 ? 'No reviews' : '$count reviews';
  }

  String _getAmountRating({
    required Map<String, dynamic> productReview,
  }) {
    final count = productReview['content']?.length ?? 0;
    return count == 0 ? 'No ratings' : '$count ratings';
  }

  @override
  Widget build(BuildContext context) {
    // Ensure productReview is not null and its content is properly handled
    final reviews = productReview['content'] ?? [];

    // If productReview is empty or contains no content, display an empty state
    if (productReview.isEmpty || reviews.isEmpty) {
      return const Scaffold(
        appBar: CSAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),
        body: Center(
          child: Text('No reviews or ratings available for this product.'),
        ),
      );
    }

    return Scaffold(
      /// -- Appbar
      appBar: const CSAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),

      /// -- Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(height: CSSize.spaceBtwItems),

              /// Overall Product Ratings
              CSOverallProductRating(productReview: productReview ?? {}),
              CSRatingBarIndicator(rating: (productReview["ratings"]?["average"]).toDouble() ?? 0,), // RatingBarIndicator
              Text(
                _getAmountRating(productReview: productReview) ?? '0',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: CSSize.spaceBtwSections),

              /// User Reviews List - Generate one UserReviewCard for each review
              Column(
                children: reviews.map<Widget>((review) {
                  return UserReviewCard(productReview: [review]); // Pass each review as a list
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}








