import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class CategoryPickerSheet extends StatelessWidget {
  final String selectedSpecialty;
  final ValueChanged<String> onSelected;

  const CategoryPickerSheet({
    super.key,
    required this.selectedSpecialty,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final specialties = [
      'plumbing'.tr(),
      'electricity'.tr(),
      'carpentry'.tr(),
      'air_conditioning'.tr(),
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'select_category'.tr(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 12),
            ...specialties.map(
              (specialty) => ListTile(
                title: Text(
                  specialty,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                trailing: selectedSpecialty == specialty
                    ? const Icon(Icons.check_circle_rounded, color: AppTheme.primaryNavy)
                    : null,
                onTap: () {
                  onSelected(specialty);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}