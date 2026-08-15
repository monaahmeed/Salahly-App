import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'status_badge.dart';
import 'technician_info_card.dart';

class ActiveBookingCard extends StatelessWidget {
  final String categoryTitle;
  final String jobId;
  final BookingStatus status;
  final String? technicianName;
  final String? technicianImage;
  final String price;
  final String estCompletionTime;
  final VoidCallback? onTrackTap;
  final VoidCallback? onCallTap;

  const ActiveBookingCard({
    super.key,
    required this.categoryTitle,
    required this.jobId,
    required this.status,
    this.technicianName,
    this.technicianImage,
    required this.price,
    required this.estCompletionTime,
    this.onTrackTap,
    this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.ac_unit, color: AppTheme.primaryNavy),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    Text(
                      '${'job_id'.tr()}: #$jobId',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.slate500,
                      ),
                    ),
                  ],
                ),
              ),
              StatusBadge(status: status),
            ],
          ),

         
          if (technicianName != null) ...[
            const SizedBox(height: 16),
            TechnicianInfoCard(
              name: technicianName!,
              imageUrl: technicianImage,
              onCallTap: onCallTap,
            ),
          ],

          const SizedBox(height: 16),

          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'total_price'.tr(),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.slate500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'est_completion'.tr(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.slate500,
                    ),
                  ),
                  Text(
                    estCompletionTime,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                ],
              ),
            ],
          ),

          
          if (status == BookingStatus.inProgress && onTrackTap != null) ...[
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: onTrackTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryNavy,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.location_on_outlined, size: 18),
                label: Text(
                  'track_technician'.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}