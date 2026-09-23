import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class TechnicianCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String technicianName;
  final String technicianSpecialty;
  final String? profileImageUrl;
  final VoidCallback? onNotificationTap;

  const TechnicianCustomAppBar({
    super.key,
    required this.technicianName,
    required this.technicianSpecialty,
    this.profileImageUrl,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage: profileImageUrl != null
                ? NetworkImage(profileImageUrl!)
                : const NetworkImage(
                    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?auto=format&fit=crop&q=80',
                  ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Salahly',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              Text(
                '$technicianName - $technicianSpecialty',
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.slate500.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none_rounded, color: AppTheme.primaryNavy),
          onPressed: onNotificationTap ?? () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}