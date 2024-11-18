class Avatar {
  final String id;
  final String name;
  final String accessibility;
  final DateTime createdAt;

  Avatar({
    required this.id,
    required this.name,
    required this.accessibility,
    required this.createdAt,
  });

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(
      id: json['id'],
      name: json['name'],
      accessibility: json['accessibility'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'accessibility': accessibility,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
