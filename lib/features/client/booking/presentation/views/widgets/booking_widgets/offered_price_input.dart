import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salahly/core/theme/app_theme.dart';

class OfferedPriceInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  const OfferedPriceInput({
    super.key,
    required this.controller, this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'offered_price'.tr(),
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryNavy,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: 'offered_price_hint'.tr(),
            hintStyle: const TextStyle(color: AppTheme.slate500, fontSize: 13),
            prefixIcon: const Icon(
              Icons.payments_outlined,
              color: AppTheme.slate500,
              size: 20,
            ),
            suffixText: 'egp'.tr(),
            suffixStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppTheme.primaryNavy,
              fontSize: 13,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppTheme.accentAmber, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}