import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly/core/services/app_router.dart';
import 'package:salahly/core/theme/app_theme.dart';

class TechnicianStatsCard extends StatelessWidget {
  final int completedJobs;
  final double rating;
  final double totalEarnings;

  const TechnicianStatsCard({
    super.key,
    required this.completedJobs,
    required this.rating,
    required this.totalEarnings,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildItem(
            value: '$completedJobs',
            label: 'completed_jobs_stat'.tr(),
            icon: Icons.check_circle_outline_rounded,
            iconColor: const Color(0xFF16A34A),
          ),
          _buildDivider(),
          _buildItem(
            value: '$rating ',
            label: 'rating_stat'.tr(),
            icon: Icons.star_rounded,
            iconColor: AppTheme.accentAmber,
            onTap: () {
              context.push(AppRouter.kTechnicianReviews);
            },
          ),
          _buildDivider(),
          _buildItem(
            value: '${'egp'.tr()} ${totalEarnings.toStringAsFixed(0)}',
            label: 'total_earnings_stat'.tr(),
            icon: Icons.account_balance_wallet_outlined,
            iconColor: const Color(0xFF2563EB),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 35,
      width: 1,
      color: const Color(0xFFE2E8F0),
    );
  }

  Widget _buildItem({
    required String value,
    required String label,
    required IconData icon,
    required Color iconColor,
    final VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 16, color: iconColor),
                const SizedBox(width: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppTheme.slate500, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}