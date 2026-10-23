import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/features/client/booking/domain/entities/booking_entity.dart';
import 'package:salahly/features/client/booking/presentation/manger/booking_cubit/bookings_cubit.dart';
import 'package:salahly/features/client/booking/presentation/manger/booking_cubit/bookings_state.dart';
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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        final cubit = context.read<BookingsCubit>();
        if (_tabController.index == 0) {
          cubit.fetchActiveBookings();
        } else if (_tabController.index == 1) {
          cubit.fetchScheduledBookings();
        } else if (_tabController.index == 2) {
          cubit.fetchHistoryBookings();
        }
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _navigateToTracking(BookingEntity booking) {
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
                
                BlocBuilder<BookingsCubit, BookingsState>(
                  builder: (context, state) {
                    if (state is FetchActiveBookingsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FetchActiveBookingsFailure) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is FetchActiveBookingsSuccess) {
                      return ActiveBookingsTabView(
                        bookings: state.bookings,
                        onTrackTap: _navigateToTracking,
                        onCallTap: (booking) {},
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                
                
                BlocBuilder<BookingsCubit, BookingsState>(
                  builder: (context, state) {
                    if (state is FetchScheduledBookingsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FetchScheduledBookingsFailure) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is FetchScheduledBookingsSuccess) {
                      return ScheduledBookingsTabView(
                        bookings: state.bookings,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                
                
                BlocBuilder<BookingsCubit, BookingsState>(
                  builder: (context, state) {
                    if (state is FetchHistoryBookingsLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FetchHistoryBookingsFailure) {
                      return Center(child: Text(state.errMessage));
                    } else if (state is FetchHistoryBookingsSuccess) {
                      return HistoryBookingsTabView(
                        bookings: state.bookings,
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}