import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly/core/models/service_request_model.dart';
import 'package:salahly/core/services/app_router.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/technician/dashboard/presentation/views/widgets/service_request_card.dart';
import 'package:salahly/features/technician/jobs/presentation/views/jobs_widgets/available_job_card.dart';
import 'package:url_launcher/url_launcher.dart';

import 'active_job_card.dart';
import 'history_job_card.dart';
import 'jobs_segmented_control.dart';

class JobsViewBody extends StatefulWidget {
  const JobsViewBody({super.key});

  @override
  State<JobsViewBody> createState() => _JobsViewBodyState();
}

class _JobsViewBodyState extends State<JobsViewBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<ServiceRequestModel> _availableRequests = [
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
  ];

  final List<ServiceRequestModel> _activeAndScheduledRequests = [
    ServiceRequestModel(
      id: '101',
      problemTitle: 'Bathroom Tap Leakage Repair',
      clientName: 'Mohamed Tarek',
      clientPhone: '01123456789',
      problemDescription: 'Tap cartridge replacement needed.',
      offeredPrice: 200,
      distanceInKm: 1.2,
      locationName: 'Nasr City, Cairo',
      status: JobStatus.inProgress,
      createdAt: DateTime.now().subtract(const Duration(minutes: 25)),
    ),
    ServiceRequestModel(
      id: '102',
      problemTitle: 'Water Heater Checkup',
      clientName: 'Ahmed Khaled',
      clientPhone: '01234567890',
      problemDescription: 'Checking heating element.',
      offeredPrice: 180,
      distanceInKm: 3.0,
      locationName: 'Maadi, Cairo',
      status: JobStatus.active,
      createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
    ),
  ];

  final List<ServiceRequestModel> _historyRequests = [
    ServiceRequestModel(
      id: '201',
      problemTitle: 'Kitchen Drain Clearing',
      clientName: 'Nour Ali',
      clientPhone: '01512345678',
      problemDescription: 'Cleared grease trap.',
      offeredPrice: 350,
      distanceInKm: 3.5,
      locationName: 'Dokki, Giza',
      status: JobStatus.completed,
      rating: 5.0,
      reviewNote: 'ممتاز وسريع جداً في الحل!',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

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

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      debugPrint('Could not launch phone: $phoneNumber');
    }
  }

  Future<void> _openExternalNavigation(double lat, double lng) async {
    final uri = Uri.parse('geo:$lat,$lng?q=$lat,$lng');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final googleMapsUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );
      await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'jobs_and_requests'.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.tune_rounded,
                  size: 16,
                  color: AppTheme.primaryNavy,
                ),
                label: Text(
                  'filter'.tr(),
                  style: const TextStyle(
                    color: AppTheme.primaryNavy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          JobsSegmentedControl(controller: _tabController),
          const SizedBox(height: 16),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _availableRequests.isEmpty
                    ? Center(
                        child: Text(
                          'no_available_jobs'.tr(),
                          style: const TextStyle(color: AppTheme.slate500),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _availableRequests.length,
                        itemBuilder: (context, index) {
                          final request = _availableRequests[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: ServiceRequestCard(
                              request: request,
                              actionButtons: AvailableJobActionButtons(
                                request: request,
                                onAccept: () {
                                  setState(() {
                                    _availableRequests.removeAt(index);
                                    _activeAndScheduledRequests.insert(
                                      0,
                                      request.copyWith(
                                        status: JobStatus.active,
                                      ),
                                    );
                                  });
                                },
                                onSendOffer: (price, time, note) {},
                              ),
                            ),
                          );
                        },
                      ),

                _activeAndScheduledRequests.isEmpty
                    ? Center(
                        child: Text(
                          'no_active_jobs'.tr(),
                          style: const TextStyle(color: AppTheme.slate500),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _activeAndScheduledRequests.length,
                        itemBuilder: (context, index) {
                          final currentRequest =
                              _activeAndScheduledRequests[index];

                          return ActiveJobCard(
                            request: currentRequest,
                            onCallClient: () => _makePhoneCall(
                              currentRequest.clientPhone ?? '01000000000',
                            ),
                            onNavigateMap: () {
                              final lat = currentRequest.latitude ?? 30.0444;
                              final lng = currentRequest.longitude ?? 31.2357;
                              _openExternalNavigation(lat, lng);
                            },
                            onStatusChange: () {
                              if (currentRequest.status ==
                                  JobStatus.inProgress) {
                                context.push(
                                  AppRouter.kTechnicianInvoiceJob,
                                  extra: currentRequest,
                                );
                              } else {
                                setState(() {
                                  _activeAndScheduledRequests[index] =
                                      currentRequest.copyWith(
                                        status: JobStatus.inProgress,
                                      );
                                });
                              }
                            },
                          );
                        },
                      ),

                _historyRequests.isEmpty
                    ? Center(
                        child: Text(
                          'no_history_jobs'.tr(),
                          style: const TextStyle(color: AppTheme.slate500),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _historyRequests.length,
                        itemBuilder: (context, index) =>
                            HistoryJobCard(request: _historyRequests[index]),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
