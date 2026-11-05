import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/booking_model.dart';

abstract class BookingsRemoteDataSource {
  Future<List<BookingModel>> fetchActiveBookings();
  Future<List<BookingModel>> fetchScheduledBookings();
  Future<List<BookingModel>> fetchHistoryBookings();
}

class BookingsRemoteDataSourceImpl implements BookingsRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  BookingsRemoteDataSourceImpl({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<List<BookingModel>> fetchActiveBookings() async {
    
    final snapshot = await firestore
        .collection('bookings')
        .where('status', isEqualTo: 'inProgress')
        .get();

     return snapshot.docs.map((doc) => BookingModel.fromFirestore(doc.data(), docId: doc.id)).toList();
  }

  @override
  Future<List<BookingModel>> fetchScheduledBookings() async {
    final snapshot = await firestore
        .collection('bookings')
        .where('status', whereIn: ['scheduled', 'pending'])
        .get();

    return snapshot.docs.map((doc) => BookingModel.fromFirestore(doc.data(), docId: doc.id)).toList();
  }

  @override
  Future<List<BookingModel>> fetchHistoryBookings() async {
    final snapshot = await firestore
        .collection('bookings')
        .where('status', whereIn: ['completed', 'cancelled'])
        .get();

    return snapshot.docs.map((doc) => BookingModel.fromFirestore(doc.data(), docId: doc.id)).toList();
  }
}