import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controllers/address_controller.dart';
import '../../models/delivery_infor.dart';
class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({super.key});

  @override
  _AddNewAddressScreenState createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final DeliveryController _controller = DeliveryController();

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _wardController = TextEditingController();

  Future<void> _saveDeliveryInfo() async {
    if (_formKey.currentState!.validate()) {
      final deliveryInfo = DeliveryInfo(
        address: _addressController.text,
        province: _provinceController.text,
        city: _cityController.text,
        district: _districtController.text,
        ward: _wardController.text,
      );

      await _controller.saveDeliveryInfo(deliveryInfo);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Delivery information saved successfully!')),
      );

      Navigator.pop(context); // Quay lại màn hình trước đó (nếu cần)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CSAppBar(showBackArrow: true, title: Text('Add New Address')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(CSSize.defaultSpace),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.user),
                    labelText: 'Address',
                  ),
                  validator: (value) => value!.isEmpty ? 'Address is required' : null,
                ),
                const SizedBox(height: CSSize.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _districtController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building_31),
                          labelText: 'District',
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'District is required' : null,
                      ),
                    ),
                    const SizedBox(width: CSSize.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: _wardController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.code),
                          labelText: 'Ward',
                        ),
                        validator: (value) => value!.isEmpty ? 'Ward is required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: CSSize.spaceBtwInputFields),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _cityController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.building),
                          labelText: 'City',
                        ),
                        validator: (value) => value!.isEmpty ? 'City is required' : null,
                      ),
                    ),
                    const SizedBox(width: CSSize.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: _provinceController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Iconsax.buildings_25),
                          labelText: 'Province',
                        ),
                        validator: (value) =>
                        value!.isEmpty ? 'Province is required' : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: CSSize.defaultSpace),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _saveDeliveryInfo,
                    child: const Text('Save'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
