import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/models/service_request_model.dart';
import 'package:salahly/features/technician/dashboard/presentation/views/widgets/custom_technician_app_bar.dart';
import 'package:salahly/features/technician/dashboard/presentation/views/widgets/online_status_banner.dart';
import 'package:salahly/features/technician/dashboard/presentation/views/widgets/request_action_buttons.dart';
import 'package:salahly/features/technician/dashboard/presentation/views/widgets/service_request_card.dart';
import 'package:salahly/features/technician/dashboard/presentation/views/widgets/technician_quick_stats_section.dart';

class DashboardViewBody extends StatefulWidget {
  const DashboardViewBody({super.key});

  @override
  State<DashboardViewBody> createState() => _DashboardViewBodyState();
}

class _DashboardViewBodyState extends State<DashboardViewBody> {
  bool _isOnline = true;

  
  final List<ServiceRequestModel> _incomingRequests = [
    const ServiceRequestModel(
      id: 'req_101',
      clientName: 'Amira Hassan',
      problemTitle: 'Plumbing Request',
      clientImage: '',
      distanceInKm: 1.8,
      locationName: 'Jumeirah',
      offeredPrice: 250,
      problemDescription:
          'Leaking kitchen pipe under the sink causing water accumulation and bad smell, needs urgent inspection and valve replacement.',
      problemPhotos: [
        'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&q=80',
        'https://images.unsplash.com/photo-1504148455328-c376907d081c?auto=format&fit=crop&q=80',
      ],
      isUrgent: true,
    ),
    const ServiceRequestModel(
      id: 'req_102',
      clientName: 'Karim Adel',
      problemTitle: 'Water Tap Repair',
      clientImage: '',
      distanceInKm: 3.2,
      locationName: 'Downtown',
      offeredPrice: 180,
      problemDescription:
          'Bathroom mixer tap leaking from handle base continuously.',
      problemPhotos: [],
      isUrgent: false,
    ),
  ];

  void _handleAccept(ServiceRequestModel request) {
    setState(() {
      _incomingRequests.removeWhere((item) => item.id == request.id);
    });
    
  }

  void _handleDecline(ServiceRequestModel request) {
    setState(() {
      _incomingRequests.removeWhere((item) => item.id == request.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTechnicianAppBar(
            technicianName: 'Omar Haddad',
            specialty: 'plumbing'.tr(),
            imageUrl: '',
            isOnline: _isOnline,
            hasUnreadNotifications: true,
            onStatusChanged: (value) {
              setState(() => _isOnline = value);
            },
            onNotificationTap: () {},
          ),
          const SizedBox(height: 16),
          if (_isOnline) ...[
            const OnlineStatusBanner(),
            const SizedBox(height: 30),
          ],
          const TechnicianQuickStatsSection(
            earnings: 450,
            completedJobs: 3,
            rating: 4.9,
          ),
          const SizedBox(height: 24),

          
          ..._incomingRequests.map(
            (request) => Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: ServiceRequestCard(
                request: request,
                actionButtons: RequestActionButtons(
                  onAccept: () => _handleAccept(request),
                  onDecline: () => _handleDecline(request),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}