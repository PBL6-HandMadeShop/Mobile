import 'package:craftshop2/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:craftshop2/features/shop/screens/product_reviews/widgets/rating_progrss_indicator.dart';
import 'package:craftshop2/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:craftshop2/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';


class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// -- Appbar
      appBar: const CSAppBar(title: Text('Reviews & Ratings'),showBackArrow: true,),

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
                const CSOverallProductRating(),
                const CSRatingBarIndicator(rating: 3.5,), // RatingBarIndicator
                Text("12,611", style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: CSSize.spaceBtwSections,),

                ///User Reviews List
                const UserReviewCard(),
                const UserReviewCard(),
                const UserReviewCard(),
                const UserReviewCard(),
              ],
            ),
          ),
        ),

    ); // Scaffold
  }
}





