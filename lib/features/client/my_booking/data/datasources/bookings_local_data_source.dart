import 'package:hive/hive.dart';
import '../models/booking_model.dart';

abstract class BookingsLocalDataSource {
  List<BookingModel> getCachedBookings();
  Future<void> cacheBookings(List<BookingModel> bookings);
}

class BookingsLocalDataSourceImpl implements BookingsLocalDataSource {
  final Box bookingsBox;

  BookingsLocalDataSourceImpl({required this.bookingsBox});

  @override
  List<BookingModel> getCachedBookings() {
    final List<dynamic> jsonList = bookingsBox.get('cached_bookings', defaultValue: []);
    
    
    return jsonList.map((e) {
      final mapData = Map<String, dynamic>.from(e as Map);
      return BookingModel.fromFirestore(mapData);
    }).toList();
  }

  @override
  Future<void> cacheBookings(List<BookingModel> bookings) async {
    
    final List<Map<String, dynamic>> jsonList = 
        bookings.map((b) => b.toJson()).toList();
        
    await bookingsBox.put('cached_bookings', jsonList);
  }
}