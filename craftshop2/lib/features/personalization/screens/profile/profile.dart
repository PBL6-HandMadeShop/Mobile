import 'package:craftshop2/common/widgets/texts/section_heading.dart';
import 'package:craftshop2/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';


import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/cs_circular_image.dart';
import '../../../../utils/constants/image_string.dart';
import '../../../../utils/constants/sizes.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const CSAppBar(showBackArrow: true, title: Text('Profile')),

      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(CSSize.defaultSpace),
            child: Column(
              children: [
                /// Profile Picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const CSCircularImage(image: CSImage.user, width: 80, height: 80),
                      TextButton(onPressed: (){}, child: const Text('Change Profile Picture')),
                    ],
                  ),
                ),

                /// details
                const SizedBox(height: CSSize.spaceBtwItems/2),

                const SizedBox(height: CSSize.spaceBtwItems),

                ///Heading Profile Info
                const CSSectionHeading(title: 'Profile Information', showActionButton: false),
                const SizedBox(height: CSSize.spaceBtwItems),

                CSProfileMenu(onPressed: (){}, title: 'Name', value: 'Coding with Me'),
                CSProfileMenu(onPressed: (){}, title: 'Username', value: 'Coding with M'),

                const SizedBox(height: CSSize.spaceBtwItems),
                const Divider(),
                const SizedBox(height: CSSize.spaceBtwItems),

                const CSSectionHeading(title: 'Personal Information', showActionButton: false),
                const SizedBox(height: CSSize.spaceBtwItems),

                CSProfileMenu(onPressed: (){}, title: 'User ID', icon: Iconsax.copy,value: '12345'),
                CSProfileMenu(onPressed: (){}, title: 'E-mail', value: 'craftshop'),
                CSProfileMenu(onPressed: (){}, title: 'Phone Number', value: '09123456767'),
                CSProfileMenu(onPressed: (){}, title: 'Gender', value: 'Male'),
                CSProfileMenu(onPressed: (){}, title: 'Birthday', value: '10/10/10'),
                const Divider(),
                const SizedBox(height: CSSize.spaceBtwItems),

                Center(
                  child: TextButton(
                      onPressed: (){},
                      child: const Text('Close Account'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red, // Set the text color to red
                      ),
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}

