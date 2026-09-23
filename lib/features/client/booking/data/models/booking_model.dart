import 'package:latlong2/latlong.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/status_badge.dart';

class BookingModel {
  final String id;
  final String categoryTitle;
  final BookingStatus status;
  final String price;
  final String estCompletionTime;
  final String? technicianName;
  final String? technicianPhone;
  final String? technicianImage;
  final LatLng? clientLocation;
  final LatLng? technicianLocation;
  final DateTime? scheduledDate;

  const BookingModel({
    required this.id,
    required this.categoryTitle,
    required this.status,
    required this.price,
    required this.estCompletionTime,
    this.technicianName,
    this.technicianPhone,
    this.technicianImage,
    this.clientLocation,
    this.technicianLocation,
    this.scheduledDate,
  });

  BookingModel copyWith({
    String? id,
    String? categoryTitle,
    BookingStatus? status,
    String? price,
    String? estCompletionTime,
    String? technicianName,
    String? technicianPhone,
    String? technicianImage,
    LatLng? clientLocation,
    LatLng? technicianLocation,
    DateTime? scheduledDate,
  }) {
    return BookingModel(
      id: id ?? this.id,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      status: status ?? this.status,
      price: price ?? this.price,
      estCompletionTime: estCompletionTime ?? this.estCompletionTime,
      technicianName: technicianName ?? this.technicianName,
      technicianPhone: technicianPhone ?? this.technicianPhone,
      technicianImage: technicianImage ?? this.technicianImage,
      clientLocation: clientLocation ?? this.clientLocation,
      technicianLocation: technicianLocation ?? this.technicianLocation,
      scheduledDate: scheduledDate ?? this.scheduledDate,
    );
  }
}