class Shipper {
  final String email;
  final String name;
  final String phoneNumber;

  Shipper({
    required this.email,
    required this.name,
    required this.phoneNumber,
  });

  factory Shipper.fromJson(Map<String, dynamic> json) {
    return Shipper(
      email: json['email'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
    );
  }
}