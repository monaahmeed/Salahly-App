import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/features/client/booking/data/models/booking_model.dart';
import 'package:salahly/features/client/booking/presentation/views/live_technician_tracking_view.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/active_bookings_tab_view.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/bookings_tab_bar.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/history_bookings_tab_view.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/scheduled_bookings_tab_view.dart';

class MyBookingsViewBody extends StatefulWidget {
  const MyBookingsViewBody({super.key});

  @override
  State<MyBookingsViewBody> createState() => _MyBookingsViewBodyState();
}

class _MyBookingsViewBodyState extends State<MyBookingsViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  
  final List<BookingModel> _activeBookings = [];
  final List<BookingModel> _scheduledBookings = [];
  final List<BookingModel> _historyBookings = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToTracking(BookingModel booking) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LiveTechnicianTrackingView(
          jobId: booking.id,
          technicianName: booking.technicianName ?? 'Specialist',
          technicianPhone: booking.technicianPhone,
          technicianImage: booking.technicianImage,
          clientLocation: booking.clientLocation ?? const LatLng(30.0444, 31.2357),
          initialTechnicianLocation: booking.technicianLocation ?? const LatLng(30.0380, 31.2280),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 12),
          BookingsTabBar(controller: _tabController),
          const SizedBox(height: 16),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ActiveBookingsTabView(
                  bookings: _activeBookings,
                  onTrackTap: _navigateToTracking,
                  onCallTap: (booking) {},
                ),
                ScheduledBookingsTabView(
                  bookings: _scheduledBookings,
                ),
                HistoryBookingsTabView(
                  bookings: _historyBookings,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}