import 'package:craftshop2/features/shop/screens/product_reviews/widgets/rating_progrss_indicator.dart';
import 'package:craftshop2/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../utils/constants/colors.dart';
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

  void _showFeedbackForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: CSSize.defaultSpace,
            right: CSSize.defaultSpace,
            top: CSSize.defaultSpace,
          ),
          child: const FeedbackForm(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Ensure productReview is not null and its content is properly handled
    final reviews = productReview['content'] ?? [];

    // If productReview is empty or contains no content, display an empty state
    if (productReview.isEmpty || reviews.isEmpty) {
      return Scaffold(
        appBar: const CSAppBar(title: Text('Reviews & Ratings'), showBackArrow: true),
        body: const Center(
          child: Text('No reviews or ratings available for this product.'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _showFeedbackForm(context),
          child: const Icon(Iconsax.add),
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
      floatingActionButton: ElevatedButton(
        onPressed: () => _showFeedbackForm(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(CSSize.md),
          backgroundColor: CSColors.black,
          side: const BorderSide(color: CSColors.black),
        ),
        child: const Text('Add Review'),
      ),
    );
  }
}

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  _FeedbackFormState createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  double _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Handle feedback submission logic here
      print('Rating: $_rating');
      print('Review: ${_reviewController.text}');
      if (_image != null) {
        print('Image: ${_image!.path}');
      }
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Add Feedback', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: CSSize.spaceBtwItems),
          RatingBar.builder(
            initialRating: 0,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
            onRatingUpdate: (rating) {
              setState(() {
                _rating = rating;
              });
            },
          ),
          const SizedBox(height: CSSize.spaceBtwItems),
          TextFormField(
            controller: _reviewController,
            decoration: const InputDecoration(
              labelText: 'Review',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your review';
              }
              return null;
            },
          ),
          const SizedBox(height: CSSize.spaceBtwItems),
          ElevatedButton(
            onPressed: _pickImage,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(CSSize.md),
              backgroundColor: CSColors.black,
              side: const BorderSide(color: CSColors.black),
            ),
            child: const Text('Pick Image'),
          ),
          if (_image != null)
            Padding(
              padding: const EdgeInsets.all(CSSize.spaceBtwItems),
              child: Image.file(_image!),
            ),
          const SizedBox(height: CSSize.spaceBtwItems),
          ElevatedButton(
            onPressed: _submitFeedback,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(CSSize.md),
              backgroundColor: CSColors.black,
              side: const BorderSide(color: CSColors.black),
            ),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}