import 'package:cloud_firestore/cloud_firestore.dart';

class BikeModel {
  final String bikeId;
  final String id;
  final GeoPoint? location;
  final GeoPoint? geofenceCenter;
  final double? geofenceRadius;
  bool locked;

  BikeModel({
    required this.bikeId,
    required this.id,
    required this.location,
    required this.geofenceCenter,
    required this.geofenceRadius,
    required this.locked,
  });

  BikeModel copyWith({
    String? bikeId,
    String? id,
    GeoPoint? location,
    GeoPoint? geofenceCenter,
    double? geofenceRadius,
    bool? locked,
  }) {
    return BikeModel(
      bikeId: bikeId ?? this.bikeId,
      id: id ?? this.id,
      location: location ?? this.location,
      geofenceCenter: geofenceCenter ?? this.geofenceCenter,
      geofenceRadius: geofenceRadius ?? this.geofenceRadius,
      locked: locked ?? this.locked,
    );
  }
}
