import 'package:flutter/material.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/active_booking_card.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/bookings_tab_bar.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/scheduled_booking_card.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/my_booking_widgets/status_badge.dart';


class MyBookingsViewBody extends StatefulWidget {
  const MyBookingsViewBody({super.key});

  @override
  State<MyBookingsViewBody> createState() => _MyBookingsViewBodyState();
}

class _MyBookingsViewBodyState extends State<MyBookingsViewBody>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
                
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    ActiveBookingCard(
                      categoryTitle: 'AC Maintenance',
                      jobId: 'SL-8291',
                      status: BookingStatus.inProgress,
                      technicianName: 'Ahmed Hassan',
                      price: 'AED 350.00',
                      estCompletionTime: '14:30 PM',
                      onTrackTap: () {},
                      onCallTap: () {},
                    ),
                   ActiveBookingCard(
                      categoryTitle: 'Emergency Plumbing',
                      jobId: 'SL-8291',
                      status: BookingStatus.completed,
                      price: 'AED 350.00',
                      estCompletionTime: '14:30 PM',
                      onTrackTap: () {},
                      onCallTap: () {},
                   )
                  ],
                ),

                
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    ScheduledBookingCard(
                      categoryTitle: 'Emergency Plumbing',
                      jobId: 'SL-8104',
                      status: BookingStatus.scheduled,
                      dateText: 'Tomorrow, 09:00 AM',
                      price: 'AED 150.00',
                    ),
                  ],
                ),

                
                ListView(
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    ScheduledBookingCard(
                      categoryTitle: 'Electrical Repair',
                      jobId: 'SL-7920',
                      status: BookingStatus.completed,
                      dateText: '02 Aug 2026, 04:00 PM',
                      price: 'AED 200.00',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}