import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'stat_card_item.dart';

class TechnicianQuickStatsSection extends StatelessWidget {
  final double earnings;
  final int completedJobs;
  final double rating;

  const TechnicianQuickStatsSection({
    super.key,
    required this.earnings,
    required this.completedJobs,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        
        StatCardItem(
          title: 'earnings'.tr(),
          prefix: 'egp'.tr(),
          value: earnings.toStringAsFixed(0),
        ),
        const SizedBox(width: 10),

        
        StatCardItem(
          title: 'jobs'.tr(),
          value: completedJobs.toString(),
        ),
        const SizedBox(width: 10),

       
        StatCardItem(
          title: 'rating'.tr(),
          value: rating.toStringAsFixed(1),
          trailingIcon: const Icon(
            Icons.star_rounded,
            size: 16,
            color: AppTheme.accentAmber,
          ),
        ),
      ],
    );
  }
}