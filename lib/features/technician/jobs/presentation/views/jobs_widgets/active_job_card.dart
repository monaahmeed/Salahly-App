import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/models/service_request_model.dart';
import 'package:salahly/core/theme/app_theme.dart';

class ActiveJobCard extends StatelessWidget {
  final ServiceRequestModel request;
  final VoidCallback onCallClient;
  final VoidCallback onNavigateMap;
  final VoidCallback onStatusChange;

  const ActiveJobCard({
    super.key,
    required this.request,
    required this.onCallClient,
    required this.onNavigateMap,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final bool isInProgress = request.status == JobStatus.inProgress;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isInProgress ? const Color(0xFF3B82F6) : const Color(0xFFF1F5F9),
          width: isInProgress ? 1.5 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.problemTitle,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    _buildStatusBadge(request.status),
                  ],
                ),
              ),
              Text(
                '${'egp'.tr()} ${request.offeredPrice.toStringAsFixed(0)}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppTheme.primaryNavy.withOpacity(0.1),
                  child: const Icon(Icons.person, color: AppTheme.primaryNavy, size: 20),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        request.clientName,
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.primaryNavy),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, size: 13, color: AppTheme.slate500),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              request.locationName,
                              style: const TextStyle(fontSize: 11, color: AppTheme.slate500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.call_rounded, color: Color(0xFF16A34A)),
                  onPressed: onCallClient,
                ),
                IconButton(
                  icon: const Icon(Icons.navigation_outlined, color: Color(0xFF2563EB)),
                  onPressed: onNavigateMap,
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          
          SizedBox(
            width: double.infinity,
            height: 44,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isInProgress ? const Color(0xFF16A34A) : AppTheme.primaryNavy,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: onStatusChange,
              child: Text(
                isInProgress ? 'complete_job'.tr() : 'start_job'.tr(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(JobStatus status) {
  String label;
  Color color;
  Color bg;

  switch (status) {
    case JobStatus.inProgress:
      label = 'in_progress'.tr(); 
      color = const Color(0xFF16A34A);
      bg = const Color(0xFFDCFCE7);
      break;
    case JobStatus.active:
      label = 'on_the_way'.tr(); 
      color = const Color(0xFF2563EB);
      bg = const Color(0xFFEFF6FF);
      break;
    case JobStatus.scheduled:
    default:
      label = 'scheduled_badge'.tr(); 
      color = const Color(0xFFD97706);
      bg = const Color(0xFFFEF3C7);
      break;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(6)),
    child: Text(
      label,
      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
    ),
  );
}
}