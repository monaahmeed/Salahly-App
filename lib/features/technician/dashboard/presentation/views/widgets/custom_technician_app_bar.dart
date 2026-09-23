import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'online_status_toggle.dart';

class CustomTechnicianAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String technicianName;
  final String specialty;
  final String? imageUrl;
  final bool isOnline;
  final ValueChanged<bool> onStatusChanged;
  final VoidCallback onNotificationTap;
  final bool hasUnreadNotifications;

  const CustomTechnicianAppBar({
    super.key,
    required this.technicianName,
    required this.specialty,
    this.imageUrl,
    required this.isOnline,
    required this.onStatusChanged,
    required this.onNotificationTap,
    this.hasUnreadNotifications = false,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final bool hasValidImage = imageUrl != null && imageUrl!.trim().isNotEmpty;

    return SafeArea(
      bottom: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        color: Colors.white,
        child: Row(
          children: [
            
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFE2E8F0),
              backgroundImage: hasValidImage ? NetworkImage(imageUrl!) : null,
              child: !hasValidImage
                  ? const Icon(Icons.person, size: 26, color: AppTheme.slate500)
                  : null,
            ),
            const SizedBox(width: 12),

            
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    technicianName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryNavy,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    specialty,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.slate500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            
            OnlineStatusToggle(
              isOnline: isOnline,
              onToggle: onStatusChanged,
            ),
            const SizedBox(width: 8),

            
            Stack(
              clipBehavior: Clip.none,
              children: [
                IconButton(
                  onPressed: onNotificationTap,
                  icon: const Icon(
                    Icons.notifications_outlined,
                    size: 26,
                    color: AppTheme.primaryNavy,
                  ),
                  splashRadius: 22,
                ),
                if (hasUnreadNotifications)
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
          ],
        ),
      ),
    );
  }
}