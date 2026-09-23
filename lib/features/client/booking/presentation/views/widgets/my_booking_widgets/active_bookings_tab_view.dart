import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/features/client/booking/data/models/booking_model.dart';
import 'active_booking_card.dart';
import 'empty_state_widget.dart';

class ActiveBookingsTabView extends StatelessWidget {
  final List<BookingModel> bookings;
  final Function(BookingModel) onTrackTap;
  final Function(BookingModel) onCallTap;

  const ActiveBookingsTabView({
    super.key,
    required this.bookings,
    required this.onTrackTap,
    required this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    if (bookings.isEmpty) {
      return EmptyStateWidget(
        title: 'no_active_bookings'.tr(),
        subtitle: 'no_active_bookings_desc'.tr(),
        buttonText: 'order_new_service'.tr(),
        onButtonPressed: () {},
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return ActiveBookingCard(
          booking: booking,
          onTrackTap: () => onTrackTap(booking),
          onCallTap: () => onCallTap(booking),
        );
      },
    );
  }
}