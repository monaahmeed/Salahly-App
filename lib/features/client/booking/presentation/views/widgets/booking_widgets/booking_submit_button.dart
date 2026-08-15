
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/theme/app_theme.dart';

class BookingSubmitButton extends StatelessWidget {
  final bool isDirectBook; 
  final VoidCallback onPressed;

  const BookingSubmitButton({
    super.key,
    required this.isDirectBook,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.accentAmber, 
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          isDirectBook ? 'send_request'.tr() : 'find_technicians'.tr(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}