import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/features/client/home/data/models/technician_model.dart';

class CustomTechnicianCard extends StatelessWidget {
  final TechnicianModel technician;
  final VoidCallback? onBookTap;

  const CustomTechnicianCard({
    super.key,
    required this.technician,
    this.onBookTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child:
                (technician.imageUrl != null && technician.imageUrl!.isNotEmpty)
                ? Image.network(
                    technician.imageUrl!,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 56,
                      height: 56,
                      color: AppTheme.slate100,
                      child: const Icon(Icons.person, color: AppTheme.slate500),
                    ),
                  )
                : Container(
                    width: 56,
                    height: 56,
                    color: AppTheme.slate100,
                    child: const Icon(Icons.person, color: AppTheme.slate500),
                  ),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  technician.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryNavy,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  technician.specialty,
                  style: TextStyle(fontSize: 12, color: AppTheme.slate500),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      technician.rating.toString(),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          ElevatedButton(
            onPressed: onBookTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryNavy,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              'book_btn'.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
