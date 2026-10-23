import 'package:fpdart/fpdart.dart';
import 'package:salahly/core/errors/failures.dart';
import 'package:salahly/features/client/booking/domain/entities/booking_entity.dart';

abstract class BookingsRepo {
  Future<Either<Failure, List<BookingEntity>>> fetchActiveBookings();
  Future<Either<Failure, List<BookingEntity>>> fetchScheduledBookings();
  Future<Either<Failure, List<BookingEntity>>> fetchHistoryBookings();
}