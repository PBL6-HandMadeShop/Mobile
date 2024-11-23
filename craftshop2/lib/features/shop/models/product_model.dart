import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String origin;
  final String productLineId;
  final String productTypeId;
  final List<String> images; // Danh sách URL hình ảnh
  final bool isFeatured; // Sản phẩm nổi bật
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.origin,
    required this.productLineId,
    required this.productTypeId,
    required this.images,
    required this.isFeatured,
    required this.createdAt,
    required this.updatedAt,
  });

  // Phương thức chuyển từ JSON sang ProductModel
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      origin: json['origin'],
      productLineId: json['productLineId'],
      productTypeId: json['productTypeId'],
      images: List<String>.from(json['images'] ?? []), // Bảo vệ nếu không có hình ảnh
      isFeatured: json['isFeatured'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  // Phương thức chuyển từ ProductModel sang JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'origin': origin,
      'productLineId': productLineId,
      'productTypeId': productTypeId,
      'images': images,
      'isFeatured': isFeatured,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
