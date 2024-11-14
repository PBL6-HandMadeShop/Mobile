import 'package:craftshop2/common/widgets/appbar/appbar.dart';
import 'package:craftshop2/utils/constants/sizes.dart';
import 'package:craftshop2/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ChangeGender extends StatefulWidget {
  const ChangeGender({super.key});




  @override
  _ChangeGenderState createState() => _ChangeGenderState();

}

class _ChangeGenderState extends State<ChangeGender> {
  final _formKey = GlobalKey<FormState>();
  bool _isMale = false;
  bool _isFemale = false;
  void _handleGenderChange(String gender) {
    setState(() {
      if (gender == 'MALE') {
        _isMale = true;
        _isFemale = false;
      } else if (gender == 'FEMALE') {
        _isMale = false;
        _isFemale = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CSAppBar(
        showBackArrow: true,
        title: Text(
          "Change Gender",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(CSSize.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Let's change your gender",
              style: Theme.of(context).textTheme.labelMedium,),
            const SizedBox(height: CSSize.spaceBtwSections),
            Form(
              child: Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Male'),
                      value: _isMale,
                      onChanged: (bool? value) {
                        _handleGenderChange('MALE');
                      },
                    ),
                  ),
                  Expanded(
                    child: CheckboxListTile(
                      title: const Text('Female'),
                      value: _isFemale,
                      onChanged: (bool? value) {
                        _handleGenderChange('FEMALE');
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: CSSize.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                // onPressed: () => api.update,
                child: const Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
