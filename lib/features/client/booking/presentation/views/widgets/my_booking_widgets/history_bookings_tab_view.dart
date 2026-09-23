import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/features/client/booking/data/models/booking_model.dart';
import 'empty_state_widget.dart';
import 'scheduled_booking_card.dart';

class HistoryBookingsTabView extends StatelessWidget {
  final List<BookingModel> bookings;

  const HistoryBookingsTabView({
    super.key,
    required this.bookings,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return EmptyStateWidget(
        title: 'no_history_bookings'.tr(),
        subtitle: 'no_history_bookings_desc'.tr(),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return ScheduledBookingCard(
          categoryTitle: booking.categoryTitle,
          jobId: 'SL-${booking.id}',
          status: booking.status,
          dateText: booking.estCompletionTime,
          price: booking.price,
        );
      },
    );
  }
}