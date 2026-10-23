import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/features/client/booking/domain/entities/booking_entity.dart';
import 'active_booking_card.dart';
import 'empty_state_widget.dart';

class ActiveBookingsTabView extends StatelessWidget {
  final List<BookingEntity> bookings;
  final Function(BookingEntity) onTrackTap;
  final Function(BookingEntity) onCallTap;

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