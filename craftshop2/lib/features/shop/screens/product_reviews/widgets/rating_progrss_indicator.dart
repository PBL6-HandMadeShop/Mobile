import 'package:craftshop2/features/shop/screens/product_reviews/widgets/progress_indicator_and_rating.dart';
import 'package:flutter/material.dart';

class CSOverallProductRating extends StatelessWidget {
  const CSOverallProductRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex:3, child: Text('4.8', style: Theme.of(context).textTheme.displayLarge)),
        Expanded(
          flex: 7,
          child: Column(
            children: [
              CSRatingProgressIndicator(text: '5', value: 1.0,),
              CSRatingProgressIndicator(text: '4', value: 0.8,),
              CSRatingProgressIndicator(text: '3', value: 0.6,),
              CSRatingProgressIndicator(text: '2', value: 0.4,),
              CSRatingProgressIndicator(text: '1', value: 0.2,),
            ],
          ),
        ),
      ],
    );
  }
}