import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/client/home/data/models/technician_model.dart';

class TechnicianHeaderCard extends StatelessWidget {
  final TechnicianModel technician;

  const TechnicianHeaderCard({
    super.key,
    required this.technician,
  });

  @override
  Widget build(BuildContext context) {
    
    final bool hasValidImage = technician.imageUrl != null &&
        technician.imageUrl!.trim().isNotEmpty;

    return Container(
      padding: const EdgeInsets.all(12),
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
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey.shade200,
                backgroundImage: hasValidImage
                    ? NetworkImage(technician.imageUrl!)
                    : null,
                child: !hasValidImage
                    ? const Icon(Icons.person, size: 30, color: AppTheme.slate500)
                    : null,
              ),
              Positioned(
                bottom: -2,
                right: -2,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.verified,
                    size: 18,
                    color: AppTheme.accentAmber,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  technician.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${technician.specialty} • ${technician.experienceYears} yrs Exp.',
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppTheme.slate500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      size: 16,
                      color: AppTheme.accentAmber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${technician.rating}',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '(${technician.reviewsCount} Reviews)',
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppTheme.slate500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}