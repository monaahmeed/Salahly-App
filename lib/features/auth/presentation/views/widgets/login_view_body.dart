import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly/features/auth/presentation/views/widgets/custom_hover_text.dart';
import 'package:salahly/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:salahly/features/auth/presentation/views/widgets/social_auth_button.dart';
import '../../../../../core/services/app_router.dart';
import '../../../../../core/theme/app_theme.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 50),

                    Text(
                      'welcome_back'.tr(),
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'login_subtext'.tr(),
                      style: TextStyle(fontSize: 14, color: AppTheme.slate500),
                    ),
                    const SizedBox(height: 32),

                    CustomTextFormField(
                      label: 'email_label'.tr(),
                      hintText: 'email_hint'.tr(),
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return 'val_email_required'.tr();
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return 'val_email_invalid'.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    CustomTextFormField(
                      label: 'password_label'.tr(),
                      hintText: 'password_hint'.tr(),
                      prefixIcon: Icons.lock_outline_rounded,
                      isPassword: true,
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'val_password_required'.tr();
                        }
                        if (value.length < 6) return 'val_password_short'.tr();
                        return null;
                      },
                    ),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          GoRouter.of(context).push(AppRouter.kForgotPasswordView);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.accentAmber,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        child: Text('forgot_password'.tr()),
                      ),
                    ),
                    const SizedBox(height: 24),

                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {}
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryNavy,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        'login_button'.tr(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            'or_continue_with'.tr(),
                            style: TextStyle(
                              color: AppTheme.slate500,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade300,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: SocialAuthButton(
                            text: 'google'.tr(),
                            icon: FontAwesomeIcons.google,
                            iconColor: const Color(0xFFF59E0B),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SocialAuthButton(
                            text: 'facebook'.tr(),
                            icon: FontAwesomeIcons.facebook,
                            iconColor: const Color(0xFF1877F2),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Center(
                      child: CustomHoverText(
                        mainText: 'dont_have_account'.tr(),
                        actionText: 'sign_up'.tr(),
                        onTap: () {
                          GoRouter.of(
                            context,
                          ).pushReplacement(AppRouter.kRegisterView);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
