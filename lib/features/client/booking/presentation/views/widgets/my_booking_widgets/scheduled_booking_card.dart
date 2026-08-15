import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'status_badge.dart';

class ScheduledBookingCard extends StatelessWidget {
  final String categoryTitle;
  final String jobId;
  final BookingStatus status;
  final String dateText;
  final String price;

  const ScheduledBookingCard({
    super.key,
    required this.categoryTitle,
    required this.jobId,
    required this.status,
    required this.dateText,
    required this.price,
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
                child: const Icon(Icons.plumbing, color: AppTheme.primaryNavy),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryTitle,
                      style: const TextStyle(
                        fontSize: 15,
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
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      size: 14, color: AppTheme.slate500),
                  const SizedBox(width: 6),
                  Text(
                    dateText,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.slate500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(
                price,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}