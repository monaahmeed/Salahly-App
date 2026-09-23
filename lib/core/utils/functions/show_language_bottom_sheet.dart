import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

void showLanguageBottomSheet(BuildContext context) {
    final currentLocale = context.locale.languageCode;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'language'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              const SizedBox(height: 16),
              
              
              ListTile(
                leading: const Icon(Icons.language, color: AppTheme.primaryNavy),
                title: const Text('English'),
                trailing: currentLocale == 'en'
                    ? const Icon(Icons.check_circle, color: AppTheme.accentAmber)
                    : null,
                onTap: () {
                  context.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              const Divider(height: 1),

              
              ListTile(
                leading: const Icon(Icons.language, color: AppTheme.primaryNavy),
                title: const Text('العربية'),
                trailing: currentLocale == 'ar'
                    ? const Icon(Icons.check_circle, color: AppTheme.accentAmber)
                    : null,
                onTap: () {
                  context.setLocale(const Locale('ar'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
