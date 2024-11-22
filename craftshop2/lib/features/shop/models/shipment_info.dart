import 'package:craftshop2/features/shop/models/shipper.dart';

class ShipmentInfo {
  final String address;
  final double latitude;
  final double longitude;
  final String receivingMethod;
  final String shipmentStatus;
  final Shipper? shipper;

  ShipmentInfo({
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.receivingMethod,
    required this.shipmentStatus,
    this.shipper,
  });

  factory ShipmentInfo.fromJson(Map<String, dynamic> json) {
    return ShipmentInfo(
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      receivingMethod: json['receivingMethod'],
      shipmentStatus: json['shipmentStatus'],
      shipper: json['shipper'] != null
          ? Shipper.fromJson(json['shipper'])
          : null,
    );
  }
}