import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class CustomCategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String prosCount;
  final VoidCallback? onTap;

  const CustomCategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.prosCount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: Colors.grey.shade100,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.amber.shade50.withOpacity(0.8),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: AppTheme.accentAmber,
                size: 24,
              ),
            ),
            const SizedBox(width: 10),

            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    prosCount,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppTheme.slate500,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}