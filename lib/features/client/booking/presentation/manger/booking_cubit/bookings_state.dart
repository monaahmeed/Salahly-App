import 'package:salahly/features/client/booking/domain/entities/booking_entity.dart';

abstract class BookingsState {}

class BookingsInitial extends BookingsState {}

class FetchActiveBookingsLoading extends BookingsState {}
class FetchActiveBookingsSuccess extends BookingsState {
  final List<BookingEntity> bookings;
  FetchActiveBookingsSuccess(this.bookings);
}
class FetchActiveBookingsFailure extends BookingsState {
  final String errMessage;
  FetchActiveBookingsFailure(this.errMessage);
}


class FetchScheduledBookingsLoading extends BookingsState {}
class FetchScheduledBookingsSuccess extends BookingsState {
  final List<BookingEntity> bookings;
  FetchScheduledBookingsSuccess(this.bookings);
}
class FetchScheduledBookingsFailure extends BookingsState {
  final String errMessage;
  FetchScheduledBookingsFailure(this.errMessage);
}


class FetchHistoryBookingsLoading extends BookingsState {}
class FetchHistoryBookingsSuccess extends BookingsState {
  final List<BookingEntity> bookings;
  FetchHistoryBookingsSuccess(this.bookings);
}
class FetchHistoryBookingsFailure extends BookingsState {
  final String errMessage;
  FetchHistoryBookingsFailure(this.errMessage);
}