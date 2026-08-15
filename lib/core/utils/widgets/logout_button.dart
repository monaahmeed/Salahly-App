import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_theme.dart';
class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutButton({super.key, required this.onLogout});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('confirm_logout_title'.tr()),
        content: Text('confirm_logout_msg'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentAmber,),
            onPressed: () {
              Navigator.pop(context);
              onLogout();
            },
            child: Text('log_out'.tr(), style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Color(0xFFFDBA74)), 
          backgroundColor: const Color(0xFFFFF7ED), 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => _showLogoutDialog(context),
        icon: const Icon(Icons.logout_rounded, color: Color(0xFFDC2626)),
        label: Text(
          'log_out'.tr(),
          style: const TextStyle(
            color: AppTheme.accentAmber,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}