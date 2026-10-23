import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/features/client/booking/domain/entities/booking_entity.dart';
import 'package:salahly/features/client/booking/domain/enums/booking_status.dart';

class BookingModel extends BookingEntity {
  const BookingModel({
    required super.id,
    required super.userId,
    required super.categoryTitle,
    super.technicianName,
    super.technicianPhone,
    super.technicianImage,
    super.clientLocation,
    super.technicianLocation,
    required super.status,
    required super.estCompletionTime,
    required super.price,
    required super.createdAt,
  });

  
  factory BookingModel.fromFirestore(Map<String, dynamic> data, {String? docId}) {
    
    LatLng? clientLatLng;
    var clientLocData = data['clientLocation'];
    if (clientLocData is GeoPoint) {
      clientLatLng = LatLng(clientLocData.latitude, clientLocData.longitude);
    } else if (clientLocData is Map) {
      clientLatLng = LatLng(
        (clientLocData['lat'] as num?)?.toDouble() ?? 0.0,
        (clientLocData['lng'] as num?)?.toDouble() ?? 0.0,
      );
    }

    
    LatLng? techLatLng;
    var techLocData = data['technicianLocation'];
    if (techLocData is GeoPoint) {
      techLatLng = LatLng(techLocData.latitude, techLocData.longitude);
    } else if (techLocData is Map) {
      techLatLng = LatLng(
        (techLocData['lat'] as num?)?.toDouble() ?? 0.0,
        (techLocData['lng'] as num?)?.toDouble() ?? 0.0,
      );
    }

    
    DateTime parsedCreatedAt;
    if (data['createdAt'] is Timestamp) {
      parsedCreatedAt = (data['createdAt'] as Timestamp).toDate();
    } else if (data['createdAt'] is String) {
      parsedCreatedAt = DateTime.tryParse(data['createdAt']) ?? DateTime.now();
    } else {
      parsedCreatedAt = DateTime.now();
    }

    return BookingModel(
      id: docId ?? data['id'] ?? '',
      userId: data['userId'] ?? '',
      categoryTitle: data['categoryTitle'] ?? '',
      technicianName: data['technicianName'],
      technicianPhone: data['technicianPhone'],
      technicianImage: data['technicianImage'],
      clientLocation: clientLatLng,
      technicianLocation: techLatLng,
      status: _parseStatus(data['status']),
      estCompletionTime: data['estCompletionTime'] ?? '',
      price: data['price'] ?? '',
      createdAt: parsedCreatedAt,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'categoryTitle': categoryTitle,
      'technicianName': technicianName,
      'technicianPhone': technicianPhone,
      'technicianImage': technicianImage,
      'clientLocation': clientLocation != null
          ? GeoPoint(clientLocation!.latitude, clientLocation!.longitude)
          : null,
      'technicianLocation': technicianLocation != null
          ? GeoPoint(technicianLocation!.latitude, technicianLocation!.longitude)
          : null,
      'status': status.name,
      'estCompletionTime': estCompletionTime,
      'price': price,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'categoryTitle': categoryTitle,
      'technicianName': technicianName,
      'technicianPhone': technicianPhone,
      'technicianImage': technicianImage,
      'clientLocation': clientLocation != null
          ? {'lat': clientLocation!.latitude, 'lng': clientLocation!.longitude}
          : null,
      'technicianLocation': technicianLocation != null
          ? {'lat': technicianLocation!.latitude, 'lng': technicianLocation!.longitude}
          : null,
      'status': status.name,
      'estCompletionTime': estCompletionTime,
      'price': price,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  static BookingStatus _parseStatus(String? statusStr) {
    switch (statusStr) {
      case 'inProgress':
      case 'active':
        return BookingStatus.inProgress;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'pending':
        return BookingStatus.pending;
      case 'scheduled':
      default:
        return BookingStatus.scheduled;
    }
  }
}