import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salahly/features/client/booking/domain/repos/bookings_repo.dart';
import 'bookings_state.dart';

class BookingsCubit extends Cubit<BookingsState> {
  final BookingsRepo bookingsRepo;

  BookingsCubit(this.bookingsRepo) : super(BookingsInitial());

  Future<void> fetchActiveBookings() async {
    emit(FetchActiveBookingsLoading());
    final result = await bookingsRepo.fetchActiveBookings();

    result.fold(
      (failure) => emit(FetchActiveBookingsFailure(failure.message)),
      (bookings) => emit(FetchActiveBookingsSuccess(bookings)),
    );
  }

  Future<void> fetchScheduledBookings() async {
    emit(FetchScheduledBookingsLoading());
    final result = await bookingsRepo.fetchScheduledBookings();

    result.fold(
      (failure) => emit(FetchScheduledBookingsFailure(failure.message)),
      (bookings) => emit(FetchScheduledBookingsSuccess(bookings)),
    );
  }

  Future<void> fetchHistoryBookings() async {
    emit(FetchHistoryBookingsLoading());
    final result = await bookingsRepo.fetchHistoryBookings();

    result.fold(
      (failure) => emit(FetchHistoryBookingsFailure(failure.message)),
      (bookings) => emit(FetchHistoryBookingsSuccess(bookings)),
    );
  }
}