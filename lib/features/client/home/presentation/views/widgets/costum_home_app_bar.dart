import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class CustomHomeAppBar extends StatelessWidget {
  final String? userImageUrl;
  final String locationName;
  final bool hasNotification;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onLocationTap;
  final File? localImageFile;

  const CustomHomeAppBar({
    super.key,
    this.userImageUrl,
    required this.locationName,
    this.hasNotification = true,
    this.onNotificationTap,
    this.onLocationTap,
    this.localImageFile,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.accentAmber, width: 2),
          ),
          child: CircleAvatar(
            radius: 22,
            backgroundColor: AppTheme.slate100,
            backgroundImage: localImageFile != null
                ? FileImage(localImageFile!) as ImageProvider
                : (userImageUrl != null ? NetworkImage(userImageUrl!) : null),
            child: userImageUrl == null
                ? const Icon(Icons.person, color: AppTheme.slate500)
                : null,
          ),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: GestureDetector(
            onTap: onLocationTap,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'location_label'.tr(),
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.slate600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppTheme.accentAmber,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        locationName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryNavy,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppTheme.primaryNavy,
                      size: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        GestureDetector(
          onTap: onNotificationTap,
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppTheme.primaryNavy,
                  size: 24,
                ),
              ),

              if (hasNotification)
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    width: 9,
                    height: 9,
                    decoration: BoxDecoration(
                      color: AppTheme.accentAmber,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
