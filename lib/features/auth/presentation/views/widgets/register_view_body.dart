import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/services/app_router.dart';
import '../../../../../core/theme/app_theme.dart';
import 'custom_hover_text.dart';
import 'customer_register_form.dart';
import 'professional_register_form.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({super.key});

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final _customerFormKey = GlobalKey<FormState>();
  final _professionalFormKey = GlobalKey<FormState>();

  int _selectedRoleIndex = 0;
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'create_account'.tr(),
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'register_subtext'.tr(),
              style: TextStyle(fontSize: 14, color: AppTheme.slate500),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppTheme.slate100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedRoleIndex = 0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedRoleIndex == 0
                              ? AppTheme.primaryNavy
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'role_customer'.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedRoleIndex == 0
                                  ? Colors.white
                                  : AppTheme.slate600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedRoleIndex = 1),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedRoleIndex == 1
                              ? AppTheme.primaryNavy
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'role_professional'.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _selectedRoleIndex == 1
                                  ? Colors.white
                                  : AppTheme.slate600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _selectedRoleIndex == 0
                  ? CustomerRegisterForm(
                      key: const ValueKey('CustomerForm'),
                      formKey: _customerFormKey,
                      agreedToTerms: _agreedToTerms,
                      onTermsChanged: (val) =>
                          setState(() => _agreedToTerms = val ?? false),
                      onSubmit: () {
                        if (_customerFormKey.currentState!.validate()) {}
                      },
                    )
                  : ProfessionalRegisterForm(
                      key: const ValueKey('ProfessionalForm'),
                      formKey: _professionalFormKey,
                      agreedToTerms: _agreedToTerms,
                      onTermsChanged: (val) =>
                          setState(() => _agreedToTerms = val ?? false),
                      onSubmit: () {
                        if (_professionalFormKey.currentState!.validate()) {}
                      },
                    ),
            ),
            const SizedBox(height: 24),

            Center(
              child: CustomHoverText(
                mainText: 'already_have_account'.tr(),
                actionText: 'login_button'.tr(),
                onTap: () {
                  GoRouter.of(context).pushReplacement(AppRouter.kLoginView);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
