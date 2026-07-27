import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'widgets/forgot_password_view_body.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppTheme.primaryNavy),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: const ForgotPasswordViewBody(),
    );
  }
}