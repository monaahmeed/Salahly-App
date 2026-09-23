import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class TechnicianAvailabilityCard extends StatelessWidget {
  final bool isAvailable;
  final ValueChanged<bool> onStatusChanged;

  const TechnicianAvailabilityCard({
    super.key,
    required this.isAvailable,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isAvailable ? const Color(0xFFF0FDF4) : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isAvailable ? const Color(0xFF86EFAC) : const Color(0xFFE2E8F0),
          width: 1.2,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isAvailable ? const Color(0xFFDCFCE7) : const Color(0xFFE2E8F0),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.power_settings_new_rounded,
              color: isAvailable ? const Color(0xFF16A34A) : AppTheme.slate500,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'online_status'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isAvailable ? const Color(0xFF15803D) : AppTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'online_status_desc'.tr(),
                  style: const TextStyle(fontSize: 11, color: AppTheme.slate500),
                ),
              ],
            ),
          ),
          Switch.adaptive(
            value: isAvailable,
            activeColor: const Color(0xFF16A34A),
            onChanged: onStatusChanged,
          ),
        ],
      ),
    );
  }
}