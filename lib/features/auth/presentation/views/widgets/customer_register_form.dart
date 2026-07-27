import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import 'custom_text_form_field.dart';

class CustomerRegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final bool agreedToTerms;
  final ValueChanged<bool?> onTermsChanged;
  final VoidCallback onSubmit;

  const CustomerRegisterForm({
    super.key,
    required this.formKey,
    required this.agreedToTerms,
    required this.onTermsChanged,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            label: 'fullname_label'.tr(),
            hintText: 'Jane Doe',
            prefixIcon: Icons.person_outline_rounded,
            validator: (val) => val == null || val.isEmpty ? 'val_required'.tr() : null,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'phone_label'.tr(),
            hintText: '+20 1XX XXX XXXX',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (val) => val == null || val.isEmpty ? 'val_required'.tr() : null,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'email_label'.tr(),
            hintText: 'you@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (val) => val == null || val.isEmpty ? 'val_required'.tr() : null,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            label: 'password_label'.tr(),
            hintText: '••••••••',
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            validator: (val) => val == null || val.length < 6 ? 'val_password_short'.tr() : null,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Checkbox(
                value: agreedToTerms,
                activeColor: AppTheme.accentAmber,
                onChanged: onTermsChanged,
              ),
              Expanded(
                child: Text(
                  'agree_terms'.tr(),
                  style: TextStyle(fontSize: 13, color: AppTheme.slate600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: agreedToTerms ? onSubmit : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentAmber,
              disabledBackgroundColor: Colors.amber.shade200,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'create_account_btn'.tr(),
              style: const TextStyle(color: AppTheme.primaryNavy, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}