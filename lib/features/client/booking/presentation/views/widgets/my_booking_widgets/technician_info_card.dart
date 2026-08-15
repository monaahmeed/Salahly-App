import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class TechnicianInfoCard extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final VoidCallback? onCallTap;

  const TechnicianInfoCard({
    super.key,
    required this.name,
    this.imageUrl,
    this.onCallTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
            child: imageUrl == null
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'technician'.tr(),
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.slate500,
                  ),
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
                ),
              ],
            ),
          ),
          if (onCallTap != null)
            Material(
              color: Colors.white,
              shape: const CircleBorder(),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: onCallTap,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.chat_bubble_outline, size: 20, color: AppTheme.primaryNavy),
                ),
              ),
            ),
        ],
      ),
    );
  }
}