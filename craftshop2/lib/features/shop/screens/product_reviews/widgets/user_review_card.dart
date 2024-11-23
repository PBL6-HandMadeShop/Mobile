import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:readmore/readmore.dart';

import '../../../../../common/widgets/custom_shape/containers/rounded_container.dart';
import '../../../../../common/widgets/images/cs_circular_image.dart';
import '../../../../../common/widgets/products/ratings/rating_indicator.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_string.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/http/api_service.dart';
import 'dart:typed_data';

class UserReviewCard extends StatefulWidget {
  const UserReviewCard({Key? key, required this.productReview}) : super(key: key);
  final List<dynamic> productReview;

  @override
  _UserReviewCardState createState() => _UserReviewCardState();
}

class _UserReviewCardState extends State<UserReviewCard> {
  final API_Services api_services = API_Services();
  final FlutterSecureStorage storage = FlutterSecureStorage();

  Map<String, dynamic>? review;
  Uint8List? fileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.productReview.isNotEmpty) {
      review = widget.productReview[0];
    }
    _loadAvatar();
  }

  Future<void> _loadAvatar() async {
    setState(() {
      isLoading = true;
    });

    try {
      String? token = await storage.read(key: 'session_token');
      if (token == null) throw Exception("Token is null");

      if (review?['author']?['avatar']?['id'] != null) {
        fileData = await api_services.downloadFile(
          review!['author']['avatar']['id'],
          token,
        );
      }
    } catch (e) {
      print('Failed to load avatar: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
  List<Widget> _parseHtml(String content) {
    final List<Widget> widgets = [];

    // Check if content is empty or just contains <br> tags
    final RegExp brTagRegExp = RegExp(r'<br\s*/?>');
    if (content.trim().isEmpty || brTagRegExp.hasMatch(content)) {
      // Return a widget with 'No review content available' if the content is empty or just <br>
      widgets.add(Text('No review content available.'));
      return widgets;
    }

    // Otherwise, process the content
    final RegExp pTagRegExp = RegExp(r'<p>(.*?)</p>', dotAll: true);

    // First, handle <p> tags
    final pMatches = pTagRegExp.allMatches(content);
    for (final match in pMatches) {
      widgets.add(Text(
        match.group(1)?.trim() ?? '',
        style: TextStyle(fontSize: 16), // Customize text style as needed
      ));
    }

    return widgets;
  }



  @override
  Widget build(BuildContext context) {
    final dark = CSHelperFunctions.isDarkMode(context);

    if (widget.productReview.isEmpty) {
      // If there are no reviews, show a placeholder or a message
      return Column(
        children: [
          const SizedBox(height: CSSize.spaceBtwItems),
          Center(
            child: Text(
              'No reviews available.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CSCircularImage(
                  image: fileData ?? CSImage.user,
                  width: 50,
                  height: 50,
                  padding: 0,
                ),
                const SizedBox(width: CSSize.spaceBtwItems),
                Text(
                  review?["author"]?["name"] ?? 'Unknown Author',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),

        // Review Content
        Row(
          children: [
            CSRatingBarIndicator(
              rating: (review?["rating"]?.toDouble() ?? 0),
            ),
            const SizedBox(width: CSSize.spaceBtwItems),
            Text(
              _formatDate(review?["updateAt"]),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        const SizedBox(height: CSSize.spaceBtwItems),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: _parseHtml(review?["context"] ?? 'No review content available.'),
        ),

        const SizedBox(height: CSSize.spaceBtwItems),

        // Company Review
        // CSRoundedContainer(
        //   backgroundColor: dark ? CSColors.darkerGrey : CSColors.grey,
        //   child: Padding(
        //     padding: const EdgeInsets.all(CSSize.md),
        //     child: Column(
        //       children: [
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Text(
        //               "T's Store",
        //               style: Theme.of(context).textTheme.titleMedium,
        //             ),
        //             Text(
        //               '02 Nov, 2023',
        //               style: Theme.of(context).textTheme.bodyMedium,
        //             ),
        //           ],
        //         ),
        //         const SizedBox(height: CSSize.spaceBtwItems),
        //         const ReadMoreText(
        //           'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
        //           trimLines: 2,
        //           trimMode: TrimMode.Line,
        //           trimExpandedText: ' show less',
        //           trimCollapsedText: ' show more',
        //           moreStyle: TextStyle(
        //             fontSize: 14,
        //             fontWeight: FontWeight.bold,
        //             color: CSColors.primaryColor,
        //           ),
        //           lessStyle: TextStyle(
        //             fontSize: 14,
        //             fontWeight: FontWeight.bold,
        //             color: CSColors.primaryColor,
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        const SizedBox(height: CSSize.spaceBtwItems),
      ],
    );
  }


  String _formatDate(String? dateString) {
    if (dateString == null) return 'Unknown Date';
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}, ${date.month.toString().padLeft(2, '0')}, ${date.year}';
    } catch (e) {
      return 'Invalid Date';
    }
  }
}
