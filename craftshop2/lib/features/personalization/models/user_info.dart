import '../../authencation/models/user_model.dart';

class UserInfo {
  final String id;
  final String username;
  final String name;
  final String email;
  final String phoneNumber;
  final String address;
  final String province;
  final String city;
  final String district;
  final String ward;
  final String gender;
  final List<int> birthDate;
  final Avatar? avatar;
  final String role;
  final String accountStatus;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserInfo({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.province,
    required this.city,
    required this.district,
    required this.ward,
    required this.gender,
    required this.birthDate,
    this.avatar,
    required this.role,
    required this.accountStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'],
      username: json['username'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      province: json['province'],
      city: json['city'],
      district: json['district'],
      ward: json['ward'],
      gender: json['gender'],
      birthDate: List<int>.from(json['birthDate']),
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      role: json['role'],
      accountStatus: json['accountStatus'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'province': province,
      'city': city,
      'district': district,
      'ward': ward,
      'gender': gender,
      'birthDate': birthDate,
      'avatar': avatar?.toJson(),
      'role': role,
      'accountStatus': accountStatus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
