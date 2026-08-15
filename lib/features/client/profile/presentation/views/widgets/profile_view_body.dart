import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:salahly/core/theme/app_theme.dart';
import 'package:salahly/core/utils/widgets/logout_button.dart';
import 'package:salahly/core/utils/widgets/profile_header.dart';
import 'package:salahly/core/utils/widgets/profile_option_tile.dart';
import 'package:salahly/features/client/booking/presentation/views/widgets/booking_widgets/pick_location_view.dart';


class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({super.key});

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
  bool _isNotificationsEnabled = true;
  String _userName = 'Mona Ahmed';
  final String _userEmail = 'mona.ahmed@example.com';
  File? _profileImage;
  String _savedAddress = 'Cairo, Egypt';
  LatLng _savedLatLng = const LatLng(30.0444, 31.2357);

  
  void _showLanguageBottomSheet(BuildContext context) {
    final currentLocale = context.locale.languageCode;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'language'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryNavy,
                ),
              ),
              const SizedBox(height: 16),
              
              
              ListTile(
                leading: const Icon(Icons.language, color: AppTheme.primaryNavy),
                title: const Text('English'),
                trailing: currentLocale == 'en'
                    ? const Icon(Icons.check_circle, color: AppTheme.accentAmber)
                    : null,
                onTap: () {
                  context.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              const Divider(height: 1),

              
              ListTile(
                leading: const Icon(Icons.language, color: AppTheme.primaryNavy),
                title: const Text('العربية'),
                trailing: currentLocale == 'ar'
                    ? const Icon(Icons.check_circle, color: AppTheme.accentAmber)
                    : null,
                onTap: () {
                  context.setLocale(const Locale('ar'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  
  Future<void> _pickLocation() async {
    final result = await Navigator.push<Map<String, dynamic>>(
      context,
      MaterialPageRoute(
        builder: (context) => PickLocationView(
          initialPosition: _savedLatLng,
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _savedLatLng = result['latLng'] as LatLng;
        _savedAddress = result['address'] as String;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEnglish = context.locale.languageCode == 'en';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(height: 10),

          
          ProfileHeader(
            userName: _userName,
            userEmail: _userEmail,
            profileImage: _profileImage,
            onImagePicked: (image) => setState(() => _profileImage = image),
            onNameEdited: (newName) => setState(() => _userName = newName),
          ),

          const SizedBox(height: 24),

          
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Column(
              children: [
                
                ProfileOptionTile(
                  icon: Icons.location_on_outlined,
                  title: 'saved_addresses'.tr(),
                  subtitle: _savedAddress,
                  onTap: _pickLocation,
                ),

                const Divider(height: 1, indent: 50),
                 ProfileOptionTile(
                  icon: Icons.language_rounded,
                  title: 'language'.tr(),
                  subtitle: isEnglish ? 'English' : 'العربية',
                  onTap: () => _showLanguageBottomSheet(context),
                ),

                const Divider(height: 1, indent: 50),

                
                ProfileOptionTile(
                  icon: Icons.notifications_none_rounded,
                  title: 'notifications'.tr(),
                  trailing: Switch(
                    activeColor: AppTheme.accentAmber,
                    value: _isNotificationsEnabled,
                    onChanged: (value) {
                      setState(() => _isNotificationsEnabled = value);
                    },
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          
          LogoutButton(
            onLogout: () {
             
            },
          ),
        ],
      ),
    );
  }
}