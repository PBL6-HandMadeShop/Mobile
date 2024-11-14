class User {
  final String? id;
  final String? username;
  final String? name;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? province;
  final String? city;
  final String? district;
  final String? ward;
  final String? gender;
  final DateTime? birthDate;
  final Avatar? avatar;
  final String? role;
  final String? accountStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.username,
    this.name,
    this.email,
    this.phoneNumber,
    this.address,
    this.province,
    this.city,
    this.district,
    this.ward,
    this.gender,
    this.birthDate,
    this.avatar,
    this.role,
    this.accountStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
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
      birthDate: json['birthDate'] != null ? DateTime.tryParse(json['birthDate']) : null,
      avatar: json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null,
      role: json['role'],
      accountStatus: json['accountStatus'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
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
      'birthDate': birthDate?.toIso8601String(),
      'avatar': avatar?.toJson(),
      'role': role,
      'accountStatus': accountStatus,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

class Avatar {
  final String? id;
  final String? name;
  final String? accessibility;
  final DateTime? createdAt;

  Avatar({
    this.id,
    this.name,
    this.accessibility,
    this.createdAt,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'],
      name: json['name'],
      accessibility: json['accessibility'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'accessibility': accessibility,
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}