import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';


class CustomDropdownFormField extends StatelessWidget {
  final String label;
  final String hintText;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const CustomDropdownFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          value: value,
          validator: validator,
          onChanged: onChanged,
          isExpanded: true,
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(16),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.primaryNavy),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppTheme.primaryNavy,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color:AppTheme.slate400, fontSize: 14),
            prefixIcon: Icon(Icons.build_outlined, color: AppTheme.slate400, size: 20),
            filled: true,
            fillColor:AppTheme.slate50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color:AppTheme.slate200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.accentAmber, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
          
          items: items.map((itemKey) {
            return DropdownMenuItem<String>(
              value: itemKey,
              child: Text(
                itemKey.tr(),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppTheme.primaryNavy,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}