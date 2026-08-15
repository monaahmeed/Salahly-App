import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly/core/theme/app_theme.dart';

class CustomBookingAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? categoryName; 
  final bool isDirectTechnicianBook; 
  const CustomBookingAppBar({
    super.key,
    this.categoryName,
    this.isDirectTechnicianBook = false,
  });

  @override
  Widget build(BuildContext context) {
    
    String appBarTitle;
    if (isDirectTechnicianBook) {
      appBarTitle = 'booking_details'.tr(); 
    } else {
      
      appBarTitle = '${'request'.tr()} ${categoryName ?? ''}'.trim();
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppTheme.primaryNavy,
          size: 20,
        ),
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      title: Text(
        appBarTitle,
        style: const TextStyle(
          color: AppTheme.primaryNavy,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}