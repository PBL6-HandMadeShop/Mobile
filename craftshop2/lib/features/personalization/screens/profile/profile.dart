import 'package:flutter/material.dart';
import 'package:pbl06new/features/personalization/screens/profile/widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget{
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Profile')),

      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                /// Profile Picture
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      const TCircularImage(image: TImage.user, width: 80, height: 80),
                      TextButton(onPressed: (){}, child: const Text('Change Profile Picture')),
                    ],
                  ),
                ),

                /// details
                const SizedBox(height: TSizes.spaceBtwItems/2),

                const SizedBox(height: TSizes.spaceBtwItems),

                ///Heading Profile Info
                const TSectionHeading(title: 'Profile Information', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),

                TProfileMenu(onPressed: (){}, title: 'name', value: 'Coding with Me'),
                const SizedBox(height: TSizes.spaceBtwItems),

                TProfileMenu(onPressed: (){}, title: 'name', value: 'Coding with Me'),
                TProfileMenu(onPressed: (){}, title: 'username', value: 'Coding with M'),

                const SizedBox(height: TSizes.spaceBtwItems),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),

                const TSectionHeading(title: 'Personal Information', showActionButton: false),
                const SizedBox(height: TSizes.spaceBtwItems),

                TProfileMenu(onPressed: (){}, title: 'username', value: 'Coding with M'),
                TProfileMenu(onPressed: (){}, title: 'username', value: 'Coding with M'),
                TProfileMenu(onPressed: (){}, title: 'username', value: 'Coding with M'),
                TProfileMenu(onPressed: (){}, title: 'username', value: 'Coding with M'),
                TProfileMenu(onPressed: (){}, title: 'username', value: 'Coding with M'),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                
                Center(
                  child: TextButton(onPressed: (){}, child: const Text('Close Account'), style: TextStyle(color: Color.red)
                  ),
                )
              ],
            ),
        ),
      ),
    );
  }
}

