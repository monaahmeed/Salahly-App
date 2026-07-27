import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
import 'custom_text_form_field.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _sendResetEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // 🛠️ هنا في المستقبل بنستدعي الـ Cubit / FirebaseAuth logic
        // await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());

        // محاكاة انتظر العملية (سانيتين)
        await Future.delayed(const Duration(seconds: 2));

        if (mounted) {
          setState(() => _isLoading = false);

          
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('reset_email_sent_success'.tr()),
              backgroundColor: Colors.green.shade700,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          );

          
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isLoading = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('reset_email_error'.tr()),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppTheme.accentAmber.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    color: AppTheme.accentAmber,
                    size: 36,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              
              Text(
                'forgot_password_title'.tr(),
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'forgot_password_subtext'.tr(),
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.slate500,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              
              CustomTextFormField(
                controller: _emailController,
                label: 'email_label'.tr(),
                hintText: 'you@example.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'val_required'.tr();
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(val)) {
                    return 'val_invalid_email'.tr();
                  }
                  return null;
                },
              ),
              const SizedBox(height: 28),

              
              ElevatedButton(
                onPressed: _isLoading ? null : _sendResetEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.accentAmber,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppTheme.primaryNavy,
                        ),
                      )
                    : Text(
                        'send_reset_link_btn'.tr(),
                        style: const TextStyle(
                          color: AppTheme.primaryNavy,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}