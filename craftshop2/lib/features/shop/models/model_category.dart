class Product {
  final int id;
  final String description;
  final String origin;
  final String name;
  final double basePrice;
  final double currentPrice;
  final int quantityRemain;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Avatar avatarBlob;
  final List<ImageBlob> imageBlobs;
  final ProductLine productLine;
  final List<ProductType> productTypes;
  final List<Voucher> vouchers;

  Product({
    required this.id,
    required this.description,
    required this.origin,
    required this.name,
    required this.basePrice,
    required this.currentPrice,
    required this.quantityRemain,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.avatarBlob,
    required this.imageBlobs,
    required this.productLine,
    required this.productTypes,
    required this.vouchers,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      description: json['description'],
      origin: json['origin'],
      name: json['name'],
      basePrice: json['basePrice'].toDouble(),
      currentPrice: json['currentPrice'].toDouble(),
      quantityRemain: json['quantityRemain'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      avatarBlob: Avatar.fromJson(json['avatarBlob']),
      imageBlobs: (json['imageBlobs'] as List).map((e) => ImageBlob.fromJson(e)).toList(),
      productLine: ProductLine.fromJson(json['productLine']),
      productTypes: (json['productTypes'] as List).map((e) => ProductType.fromJson(e)).toList(),
      vouchers: (json['vouchers'] as List).map((e) => Voucher.fromJson(e)).toList(),
    );
  }
}

class Avatar {
  final int id;
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
}

class ImageBlob {
  final int id;
  final String name;
  final String accessibility;
  final DateTime createdAt;

  ImageBlob({
    required this.id,
    required this.name,
    required this.accessibility,
    required this.createdAt,
  });

  factory ImageBlob.fromJson(Map<String, dynamic> json) {
    return ImageBlob(
      id: json['id'],
      name: json['name'],
      accessibility: json['accessibility'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}

class ProductLine {
  final int id;
  final String description;
  final String name;
  final double basePrice;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductLine({
    required this.id,
    required this.description,
    required this.name,
    required this.basePrice,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductLine.fromJson(Map<String, dynamic> json) {
    return ProductLine(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      basePrice: json['basePrice'].toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class ProductType {
  final int id;
  final String description;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductType({
    required this.id,
    required this.description,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductType.fromJson(Map<String, dynamic> json) {
    return ProductType(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Voucher {
  final int id;
  final String description;
  final String name;
  final String? code;
  final String discountType;
  final double value;
  final String voucherType;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime startedAt;
  final DateTime expiredAt;

  Voucher({
    required this.id,
    required this.description,
    required this.name,
    this.code,
    required this.discountType,
    required this.value,
    required this.voucherType,
    required this.createdAt,
    required this.updatedAt,
    required this.startedAt,
    required this.expiredAt,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) {
    return Voucher(
      id: json['id'],
      description: json['description'],
      name: json['name'],
      code: json['code'],
      discountType: json['discountType'],
      value: json['value'].toDouble(),
      voucherType: json['voucherType'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      startedAt: DateTime.parse(json['startedAt']),
      expiredAt: DateTime.parse(json['expiredAt']),
    );
  }
}
