import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import '../enums/booking_status.dart';

class BookingEntity extends ListEquality {
  final String id;
  final String userId;
  final String categoryTitle;
  final String? technicianName;
  final String? technicianPhone;
  final String? technicianImage;
  final LatLng? clientLocation;
  final LatLng? technicianLocation;
  final BookingStatus status;
  final String estCompletionTime;
  final String price;
  final DateTime createdAt;

  const BookingEntity({
    required this.id,
    required this.userId,
    required this.categoryTitle,
    this.technicianName,
    this.technicianPhone,
    this.technicianImage,
    this.clientLocation,
    this.technicianLocation,
    required this.status,
    required this.estCompletionTime,
    required this.price,
    required this.createdAt,
  });


  List<Object?> get props => [
        id,
        userId,
        categoryTitle,
        technicianName,
        status,
        price,
        createdAt,
      ];
}