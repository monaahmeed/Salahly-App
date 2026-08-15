import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:salahly/core/theme/app_theme.dart';

class MainNavigationView extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigationView({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell, 
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          
          currentIndex: navigationShell.currentIndex,
          onTap: (index) {
            
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: AppTheme.accentAmber,
          unselectedItemColor: AppTheme.slate500,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home_outlined),
              activeIcon: const Icon(Icons.home_rounded),
              label: 'home_tab'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.calendar_today_outlined),
              activeIcon: const Icon(Icons.calendar_today_rounded),
              label: 'bookings_tab'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.chat_bubble_outline_rounded),
              activeIcon: const Icon(Icons.chat_bubble_rounded),
              label: 'chat_tab'.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline_rounded),
              activeIcon: const Icon(Icons.person_rounded),
              label: 'profile_tab'.tr(),
            ),
          ],
        ),
      ),
    );
  }
}