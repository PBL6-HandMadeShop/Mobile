import 'package:flutter/material.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../personalization/models/user_info.dart';

class CSBillingAddressSection extends StatelessWidget {
  final UserInfo userInfo;

  const CSBillingAddressSection({super.key, required this.userInfo});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CSSectionHeading(
          title: 'Shipping Address',
          buttonTitle: 'Change',
          onPressed: () {},
        ),
        // Thay 'Coding with T' bằng tên người dùng lấy từ đối tượng userInfo
        Text(userInfo.name, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: CSSize.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.phone, color: Colors.grey, size: 16),
            const SizedBox(width: CSSize.spaceBtwItems),
            Text(userInfo.phoneNumber, style: Theme.of(context).textTheme.bodyMedium),
          ], // Các phần tử trong Row
        ), // Row
        const SizedBox(height: CSSize.spaceBtwItems / 2),
        Row(
          children: [
            const Icon(Icons.location_history, color: Colors.grey, size: 16),
            const SizedBox(width: CSSize.spaceBtwItems),
            Expanded(
              child: Text(
                userInfo.address,
                style: Theme.of(context).textTheme.bodyMedium,
                softWrap: true,
              ),
            ),
          ], // Các phần tử trong Row
        ), // Row
      ], // Các phần tử trong Column
    ); // Column
  }
}
