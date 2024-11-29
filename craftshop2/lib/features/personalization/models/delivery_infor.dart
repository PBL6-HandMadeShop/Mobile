class DeliveryInfo {

  String address;
  String province;
  String city;
  String district;
  String ward;

  DeliveryInfo({

    required this.address,
    required this.province,
    required this.city,
    required this.district,
    required this.ward,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'province': province,
      'city': city,
      'district': district,
      'ward': ward,
    };
  }

  factory DeliveryInfo.fromMap(Map<String, dynamic> map) {
    return DeliveryInfo(
      address: map['address'],
      province: map['province'],
      city: map['city'],
      district: map['district'],
      ward: map['ward'],
    );
  }
}
