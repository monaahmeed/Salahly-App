import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:salahly/core/utils/functions/file_picker_helper.dart';
import 'package:salahly/features/auth/presentation/views/widgets/custom_dropdown_for_field.dart';
import '../../../../../core/theme/app_theme.dart';
import 'custom_text_form_field.dart';
import 'upload_id_box.dart';

class ProfessionalRegisterForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool agreedToTerms;
  final ValueChanged<bool?> onTermsChanged;
  final VoidCallback onSubmit;

  const ProfessionalRegisterForm({
    super.key,
    required this.formKey,
    required this.agreedToTerms,
    required this.onTermsChanged,
    required this.onSubmit,
  });

  @override
  State<ProfessionalRegisterForm> createState() =>
      _ProfessionalRegisterFormState();
}

class _ProfessionalRegisterFormState extends State<ProfessionalRegisterForm> {
  String? _selectedSpecialty;
  String? _selectedFileName;
  String? _idFileError;
  File? _selectedIdFile;
  final List<String> _specialties = [
    'plumbing',
    'electricity',
    'air_conditioning',
    'carpentry',
    'painting',
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomTextFormField(
            label: 'fullname_label'.tr(),
            hintText: 'Jane Doe',
            prefixIcon: Icons.person_outline_rounded,
            validator: (val) =>
                val == null || val.isEmpty ? 'val_required'.tr() : null,
          ),
          const SizedBox(height: 16),

          CustomTextFormField(
            label: 'phone_label'.tr(),
            hintText: '+20 1XX XXX XXXX',
            prefixIcon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            validator: (val) =>
                val == null || val.isEmpty ? 'val_required'.tr() : null,
          ),
          const SizedBox(height: 16),

          CustomTextFormField(
            label: 'email_label'.tr(),
            hintText: 'you@example.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (val) =>
                val == null || val.isEmpty ? 'val_required'.tr() : null,
          ),
          const SizedBox(height: 16),

          CustomTextFormField(
            label: 'password_label'.tr(),
            hintText: '••••••••',
            prefixIcon: Icons.lock_outline_rounded,
            isPassword: true,
            validator: (val) => val == null || val.length < 6
                ? 'val_password_short'.tr()
                : null,
          ),
          const SizedBox(height: 16),

          CustomDropdownFormField(
            label: 'choose_specialty'.tr(),
            hintText: 'select_trade_hint'.tr(),
            value: _selectedSpecialty,
            items: _specialties,
            validator: (val) => val == null ? 'val_required'.tr() : null,
            onChanged: (val) {
              setState(() {
                _selectedSpecialty = val;
              });
            },
          ),
          const SizedBox(height: 20),

          UploadIdBox(fileName: _selectedFileName, onTap: _onUploadTap),
          if (_idFileError != null) ...[
            const SizedBox(height: 6),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _idFileError!,
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
          const SizedBox(height: 16),

          Row(
            children: [
              Checkbox(
                value: widget.agreedToTerms,
                activeColor: AppTheme.accentAmber,
                onChanged: widget.onTermsChanged,
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
            
            onPressed: widget.agreedToTerms ? _submitForm : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.accentAmber,
              disabledBackgroundColor: Colors.amber.shade200,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              'create_account_btn'.tr(),
              style: const TextStyle(
                color: AppTheme.primaryNavy,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onUploadTap() async {
    File? file = await FilePickerHelper.pickDocumentFile(
      onError: (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.redAccent,
          ),
        );
      },
    );

    if (file != null) {
      setState(() {
        _selectedIdFile = file;
        _selectedFileName = file.path.split('/').last;
        _idFileError = null;
      });
    }
  }

  void _submitForm() {
    if (_selectedIdFile == null) {
      setState(() {
        _idFileError = 'val_required'.tr();
      });
    } else {
      setState(() {
        _idFileError = null;
      });
    }

    if (widget.formKey.currentState!.validate() && _selectedIdFile != null) {
      widget.onSubmit();
    }
  }
}
