import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class ProblemDescriptionInput extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const ProblemDescriptionInput({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'describe_problem_title'.tr(),
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppTheme.slate500,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 8),

        TextField(
          controller: controller,
          maxLines: 4,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 14, color: AppTheme.primaryNavy),
          decoration: InputDecoration(
            hintText: 'describe_problem_hint'.tr(),
            hintStyle: TextStyle(
              fontSize: 13,
              color: AppTheme.slate500.withOpacity(0.6),
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.all(16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppTheme.primaryNavy,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
