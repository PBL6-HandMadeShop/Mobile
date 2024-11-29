class ProductDetail {
  final String id;
  final String description;
  final String origin;
  final String name;
  final double basePrice;
  final double currentPrice;
  final int quantityRemain;
  final String status;
  final String createdAt;
  final String updatedAt;
  final AvatarBlob avatarBlob;
  final List<ImageBlob> imageBlobs;
  final ProductLine productLine;
  final List<ProductType> productTypes;
  final List<Voucher> vouchers;

  ProductDetail({
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

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    return ProductDetail(
      id: json['id'],
      description: json['description'],
      origin: json['origin'],
      name: json['name'],
      basePrice: json['basePrice'].toDouble(),
      currentPrice: json['currentPrice'].toDouble(),
      quantityRemain: json['quantityRemain'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      avatarBlob: AvatarBlob.fromJson(json['avatarBlob']),
      imageBlobs: List<ImageBlob>.from(json['imageBlobs'].map((x) => ImageBlob.fromJson(x))),
      productLine: ProductLine.fromJson(json['productLine']),
      productTypes: List<ProductType>.from(json['productTypes'].map((x) => ProductType.fromJson(x))),
      vouchers: List<Voucher>.from(json['vouchers'].map((x) => Voucher.fromJson(x))),
    );
  }
}

class AvatarBlob {
  final String id;
  final String name;
  final String accessibility;
  final String createdAt;

  AvatarBlob({
    required this.id,
    required this.name,
    required this.accessibility,
    required this.createdAt,
  });

  factory AvatarBlob.fromJson(Map<String, dynamic> json) {
    return AvatarBlob(
      id: json['id'],
      name: json['name'],
      accessibility: json['accessibility'],
      createdAt: json['createdAt'],
    );
  }
}

class ImageBlob {
  final String id;
  final String name;
  final String accessibility;
  final String createdAt;

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
      createdAt: json['createdAt'],
    );
  }
}

class ProductLine {
  final String id;
  final String description;
  final String name;
  final double basePrice;
  final String createdAt;
  final String updatedAt;

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
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class ProductType {
  final String id;
  final String description;
  final String name;
  final String createdAt;
  final String updatedAt;

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
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class Voucher {
  final String id;
  final String description;
  final String name;
  final String code;
  final String discountType;
  final double value;
  final String voucherType;
  final String createdAt;
  final String updatedAt;
  final String startedAt;
  final String expiredAt;

  Voucher({
    required this.id,
    required this.description,
    required this.name,
    required this.code,
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
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      startedAt: json['startedAt'],
      expiredAt: json['expiredAt'],
    );
  }
}
