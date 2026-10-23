import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/features/client/booking/domain/entities/booking_entity.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/history_booking_card.dart';
import 'empty_state_widget.dart';

class HistoryBookingsTabView extends StatelessWidget {
  final List<BookingEntity> bookings;

  const HistoryBookingsTabView({super.key, required this.bookings});

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
        return HistoryBookingCard(booking: booking);
      },
    );
  }
}
