import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:salahly/core/theme/app_theme.dart';

class CustomClientName extends StatelessWidget {
  const CustomClientName({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          'mona'.tr(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'fixing'.tr(),
          style: TextStyle(fontSize: 14, color: AppTheme.slate600),
        ),
      ],
    );
  }
}
