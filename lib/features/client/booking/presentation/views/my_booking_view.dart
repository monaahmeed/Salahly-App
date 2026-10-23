import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; 
import 'package:salahly/core/services/service_locator.dart';
import 'package:salahly/features/client/booking/presentation/manger/booking_cubit/bookings_cubit.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/my_bookings_view_body.dart';

class MyBookingsView extends StatelessWidget {
  const MyBookingsView({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => getIt<BookingsCubit>()..fetchActiveBookings(),
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          title: Text('my_bookings_title'.tr()),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_rounded),
              onPressed: () {},
            ),
          ],
        ),
        body: const MyBookingsViewBody(),
      ),
    );
  }
}